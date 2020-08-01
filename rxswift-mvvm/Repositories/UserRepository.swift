//
//  UserRepository.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 8/1/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepositoryInterface {
    func login(email: String, password: String) -> Observable<User>
    func signup(email: String, password: String, age: String) -> Observable<User>
    func getCurrentUser() -> Observable<User>
}

class UserMockRepository: UserRepositoryInterface {

    private let repository: MockNetworkingRepository<User>

    init() {
        self.repository = MockNetworkingRepository<User>()
    }
}

extension UserMockRepository {
    func login(email: String, password: String) -> Observable<User> {
        self.repository.get(query: "onboarding-success", sortDescriptors: nil)
    }
    
    func signup(email: String, password: String, age: String) -> Observable<User> {
        self.repository.get(query: "onboarding-success", sortDescriptors: nil)
    }
    
    func getCurrentUser() -> Observable<User> {
        self.repository.get(query: "onboarding-success", sortDescriptors: nil)
    }
}
