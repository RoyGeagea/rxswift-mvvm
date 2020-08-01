//
//  ApplicationCoordinator.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/30/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    
    private let window: UIWindow!
    private var loginPageCoordinator: OnboardingPageCoordinator?
    private var imagesListPageCoordinator: ImagesListPageCoordinator?
    
    deinit {
        print("deinit \(String(describing: self))")
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        self.loginPageCoordinator = OnboardingPageCoordinator(window: self.window, isLogin: true)
        self.loginPageCoordinator?.delegate = self
        self.loginPageCoordinator?.start()
    }
    
}

extension ApplicationCoordinator: OnboardingPageCoordinatorDelegate {
    func didFinishLoginPageCoordinator() {
        self.loginPageCoordinator = nil

        self.imagesListPageCoordinator = ImagesListPageCoordinator(window: self.window)
        self.imagesListPageCoordinator?.start()
    }
}
