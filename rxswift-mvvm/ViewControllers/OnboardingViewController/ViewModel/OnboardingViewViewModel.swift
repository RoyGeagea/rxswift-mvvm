//
//  LoginViewViewModel.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/30/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class OnboardingViewViewModel {
    
    private var emptyResponse: PublishSubject<User> = PublishSubject<User>()
    private var error = PublishSubject<String>()

    var emptyResponseObservable: Observable<User> {
        return self.emptyResponse.asObservable()
    }
    var errorObservable: Observable<String> {
        return self.error.asObservable()
    }
    
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    
    private let loginRepository: UserRepositoryInterface!
    
    private let disposeBag = DisposeBag()
    
    init(loginRepository: UserRepositoryInterface) {
        self.loginRepository = loginRepository
    }
    
    func login(email: String, password: String) {
        self.loginRepository
            .login(email: email, password: password)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.emptyResponse.onNext(response)
                },
                onError: { error in
                    self.error.onNext(error.localizedDescription)
                }
            ).disposed(by: disposeBag)
    }
    
}

extension OnboardingViewViewModel {
    
    func isValidEmail(text: String?) -> Bool {
        guard let text = text else {
            return false
        }
        return text.isValidEmail()
    }
    
    func isValidPassword(text: String?) -> Bool {
        guard let text = text else {
            return false
        }
        return text.count >= 6 && text.count <= 12
    }
    
    func isValidAge(age: String?) -> Bool {
        guard let age = age else {
            return false
        }
        if let age = Int(age) {
            return age >= 18 && age <= 99
        }
        return false
    }
}
