//
//  EditionsEndPoint.swift
//  Kodmus
//
//  Created by Roy Geagea on 9/17/19.
//  Copyright © 2019 KODMUS. All rights reserved.
//

import RxSwift

public enum OnboardingAPI {
    case login(email: String, password: String)
    case signup(email: String, password: String, age: String)
}

extension OnboardingAPI: EndPointType {

    var path: String {
        switch self {
            case .login:
                return "api/user/login"
            case .signup:
                return "api/user/signup"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
            case .login, .signup:
                return .post
        }
    }

    var task: HTTPTask {
        switch self {
            case .login(let email, let password):
                return .requestParametersAndHeaders(bodyParameters: ["email": email, "password": password],
                                  bodyEncoding: .urlEncoding,
                                  urlParameters: [:], additionHeaders: headers)
            case .signup(let email, let password, let age):
                return .requestParametersAndHeaders(bodyParameters: ["email": email, "password": password, "age": age],
                                  bodyEncoding: .urlEncoding,
                                  urlParameters: [:], additionHeaders: headers)
        }
    }

    var headers: HTTPHeaders? {
        nil
    }
}
