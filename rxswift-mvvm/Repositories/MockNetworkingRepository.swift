//
//  MockNetworkingRepository.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 8/1/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation
import RxSwift

class MockNetworkingRepository<T: Codable>: Repository {
    typealias Entity = T
    typealias Query = String
    typealias Sorter = String
    
    func get(query: Query?, sortDescriptors: Sorter?) -> Observable<Entity> {
        return Observable.create { observer -> Disposable in
            let data = AppHelper.loadStubFromBundle(withName: query ?? "", extension: "json")
            let response: Entity = try! JSONDecoder().decode(Entity.self, from: data)
            observer.onNext(response)
            observer.onCompleted()
            return Disposables.create()
        }
    }

    func create() -> Observable<T> {
        fatalError("this function is not supported")
    }

    func delete(entity: T) -> Observable<Bool> {
        fatalError("this function is not supported")
    }
}
