//
//  Repository.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 8/1/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation
import RxSwift

protocol Repository {
    associatedtype Entity
    associatedtype Query
    associatedtype Sorter

    func get(query: Query?, sortDescriptors: Sorter?) -> Observable<Entity>
    
    func create() -> Observable<Entity>

    func delete(entity: Entity) -> Observable<Bool>
}
