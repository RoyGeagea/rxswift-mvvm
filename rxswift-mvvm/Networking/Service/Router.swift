//
//  Router.swift
//  Kodmus
//
//  Created by Roy Geagea on 3/15/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?)->Void

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router<EndPoint: EndPointType>: NSObject, NetworkRouter, URLSessionTaskDelegate, URLSessionDataDelegate {
    
    var backgroundCompletionHandler: NetworkRouterCompletion?

    private let temporaryFilePath = "kodmustemoraryfile"
    private let kps = ["KRzKZztq8UMyGOFcTiBppjD0+PysEEM/fk1eQWJwIDo=", "Ugsfhx/SS2qbsqrYCPRA452BUc/gHsm9zRvHnktdWok=", "Y9mvm0exBk1JoQ57f9Vm28jKo5lFm/woKcVxrYxu80o="]
    
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        switch route.task {
            case .uploadFileWithParametersAndHeaders(
                                        let body,
                                        _,
                                        _):
                do {
                    let request = try self.buildRequest(from: route)
                    NetworkLogger.log(request: request)
                    let config = URLSessionConfiguration.background(withIdentifier: "\(Date().timeIntervalSince1970)")
                    let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
                    let tempDir = FileManager.default.temporaryDirectory
                    let localURL = tempDir.appendingPathComponent(temporaryFilePath)
                    try? body.write(to: localURL)
                    backgroundCompletionHandler = completion
                    let task = session.uploadTask(with: request, fromFile: localURL)
                    task.resume()
                }
                catch {
                    print(error.localizedDescription)
                }
            default:
                do {
                    let sessionConfig = URLSessionConfiguration.default
                    sessionConfig.timeoutIntervalForRequest = 120
                    sessionConfig.timeoutIntervalForResource = 120
                    let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
                    let request = try self.buildRequest(from: route)
                    NetworkLogger.log(request: request)
                    task = session.dataTask(with: request, completionHandler: { data, response, error in
                        NetworkLogger.log(response: response, data: data, error: error)
                        completion(data, response, error)
                    })
                } catch {
                    NetworkLogger.log(response: nil, data: nil, error: error)
                    completion(nil, nil, error)
                }
                self.task?.resume()
        }
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: URL(string: NetworkManager.baseUrl.rawValue + route.path)!,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 120)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
                case .requestParameters(let bodyParameters,
                                        let bodyEncoding,
                                        let urlParameters):
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    try self.configureParameters(bodyParameters: bodyParameters,
                                                 bodyEncoding: bodyEncoding,
                                                 urlParameters: urlParameters,
                                                 request: &request)
                    
                case .requestParametersAndHeaders(let bodyParameters,
                                                  let bodyEncoding,
                                                  let urlParameters,
                                                  let additionalHeaders):
                    
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    self.addAdditionalHeaders(additionalHeaders, request: &request)
                    try self.configureParameters(bodyParameters: bodyParameters,
                                                 bodyEncoding: bodyEncoding,
                                                 urlParameters: urlParameters,
                                                 request: &request)
                    
                case .requestBodyAndHeaders(let body,
                                            _,
                                            _,
                                            let additionHeaders):
                    
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    self.addAdditionalHeaders(additionHeaders, request: &request)
                    request.httpBody = body
                    
                case .uploadFileWithParametersAndHeaders(
                                            let body,
                                            let additionHeaders,
                                            let boundary):
                    
                    request.setValue("multipart/form-data; boundary=" + boundary, forHTTPHeaderField: "Content-Type")
                    self.addAdditionalHeaders(additionHeaders, request: &request)
                    request.httpBody = body
                case .request:
                    break
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    /// Create boundary string for multipart/form-data request
    ///
    /// - returns:            The boundary string that consists of "Boundary-" followed by a UUID string.
    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    // MARK: - URLSessionTaskDelegate
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            backgroundCompletionHandler!(nil, task.response, error)
        }
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                let keyPinner = PublicKeyPinner(hashes: self.kps)
                if keyPinner.validate(serverTrust: serverTrust, domain: nil) {
                    completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
                    return
                }
            }
        }

        // Pinning failed
        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
    }
    
    // MARK: - URLSessionDataDelegate
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        backgroundCompletionHandler!(data, dataTask.response, nil)
    }
    
}
