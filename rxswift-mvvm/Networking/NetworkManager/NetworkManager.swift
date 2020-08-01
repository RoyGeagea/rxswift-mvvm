//
//  NetworkManager.swift
//  Kodmus
//
//  Created by Roy Geagea on 4/26/19.
//  Copyright © 2019 KODMUS. All rights reserved.
//

import Foundation
import RxSwift

enum BaseUrl: String {
    case development = "https://pixabay.com/"
}

enum NetworkResponse: String {
    case success
    case noData = "Response returned with no data."
    case failed = "Network request failed."
    case unableToDecode = "We could not understand the returned data."
    case unknownError = "Unknown Error"
}

enum Result<String> {
    case success
    case fourHundredErrorCode
    case failure(String)
}

public enum PaginationRequestType: String {
    case older = "before"
    case newer = "after"
}

let noDataErrorCode = -1
let failedErrorCode = -2
let unProcessedCall = 400
let unabletoDecodeErrorCode = -3

open class NetworkManager: NSObject {
    static let baseUrl: BaseUrl = .development
    
    class var sharedInstance: NetworkManager {
        struct Singleton {
            static let instance = NetworkManager()
        }
        return Singleton.instance
    }
    
    private override init() {
        super.init()
    }
    
    func request<T: Codable, W: EndPointType>(endPointType: W) -> Observable<T> {
        let router = Router<W>()
        return Observable.create { observer -> Disposable in
            router.request(endPointType) { data, response, error in
                
                if let error = error {
                    observer.onError(error)
                }
                
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            observer.onError(NSError(domain: "", code: noDataErrorCode, userInfo: [NSLocalizedDescriptionKey: NetworkResponse.noData.rawValue]))
                            return
                        }
                        do {
                            let decoder = JSONDecoder()
                            let apiResponse = try decoder.decode(T.self, from: responseData)
                            observer.onNext(apiResponse)
                            observer.onCompleted()
                        } catch {
                            observer.onError(NSError(domain: "", code: unabletoDecodeErrorCode, userInfo: [NSLocalizedDescriptionKey: NetworkResponse.unableToDecode.rawValue]))
                        }
                    case .failure(let networkFailureError):
                        observer.onError(NSError(domain: "", code: response.statusCode, userInfo:
                            [NSLocalizedDescriptionKey: networkFailureError]))
                    case .fourHundredErrorCode:
                        guard let responseData = data else {
                            observer.onError(NSError(domain: "", code: noDataErrorCode, userInfo: [NSLocalizedDescriptionKey: NetworkResponse.noData.rawValue]))
                            return
                        }
                        let error400 = Error400(code: response.statusCode, message: String(data: responseData, encoding: .utf8) ?? "")
                        observer.onError(NSError(domain: "", code: error400.code , userInfo: [NSLocalizedDescriptionKey: error400.message ]))
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
            case 200...299: return .success
            case 400...499 : return.fourHundredErrorCode
            default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
