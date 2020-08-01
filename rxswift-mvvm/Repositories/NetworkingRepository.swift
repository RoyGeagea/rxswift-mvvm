//
//  NetworkingRepository.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 8/1/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation
import RxSwift

class NetworkingRepository<T: Codable, U: EndPointType>: Repository {
    
    typealias Entity = T
    typealias Query = U
    typealias Sorter = String

    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func get(query: Query?, sortDescriptors: Sorter?) -> Observable<Entity> {
        guard let query = query else {
            fatalError("a query is required")
        }
        let obvs: Observable<Entity>! = self.networkManager.request(endPointType: query)
        return obvs
    }

    func create() -> Observable<T> {
        fatalError("this function is not supported")
    }

    func delete(entity: T) -> Observable<Bool> {
        fatalError("this function is not supported")
    }
}
