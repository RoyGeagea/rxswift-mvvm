//
//  EndPointType.swift
//  Kodmus
//
//  Created by Roy Geagea on 3/15/19.
//  Copyright © 2019 RoyG. All rights reserved.
//

import Foundation

protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
