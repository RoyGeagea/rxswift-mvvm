//
//  ImagesAPI.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/31/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import RxSwift

public enum ImagesAPI {
    case getImages(key: String)
}

extension ImagesAPI: EndPointType {

    var path: String {
        switch self {
            case .getImages(let key):
                return "api/?key=\(key)&lang=en"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
            case .getImages:
                return .get
        }
    }

    var task: HTTPTask {
        switch self {
            case .getImages:
                return .requestParametersAndHeaders(bodyParameters: nil,
                                  bodyEncoding: .urlEncoding,
                                  urlParameters: [:], additionHeaders: headers)
        }
    }

    var headers: HTTPHeaders? {
        nil
    }
}


