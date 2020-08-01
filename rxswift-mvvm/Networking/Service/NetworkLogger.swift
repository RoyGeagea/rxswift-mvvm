//
//  NetworkLogger.swift
//  Kodmus
//
//  Created by Roy Geagea on 3/15/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {
        
        CocoaLumberjackService.shared.log("\n - - - - - - - - - - HTTP-REQUEST - - - - - - - - - - \n")
        defer { CocoaLumberjackService.shared.log("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
        \(urlAsString) \n\n
        \(method) \(path)?\(query) HTTP/1.1 \n
        HOST: \(host)\n
        """
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        CocoaLumberjackService.shared.log(logOutput)
    }
    
    static func log(response: URLResponse?, data: Data?, error: Error?) {
        CocoaLumberjackService.shared.log("\n - - - - - - - - - - HTTP-RESPONSE - - - - - - - - - - \n")
        defer { CocoaLumberjackService.shared.log("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        if response != nil {
            CocoaLumberjackService.shared.log(response!.debugDescription)
        }
        if data != nil {
            CocoaLumberjackService.shared.log(String(data: data!, encoding: .utf8)!)
        }
        if error != nil {
            CocoaLumberjackService.shared.log(error!.localizedDescription)
        }
    }
}
