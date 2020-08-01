//
//  HTTPTask.swift
//  Kodmus
//
//  Created by Roy Geagea on 3/15/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
    
    case requestBodyAndHeaders(body: Data,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
    
    // case download, upload...etc
    
    case uploadFileWithParametersAndHeaders(body: Data,
        additionHeaders: HTTPHeaders?, boundary: String)
}
