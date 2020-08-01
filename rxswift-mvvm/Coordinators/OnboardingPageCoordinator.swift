//
//  OnboardingCoordinator.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/30/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation
import UIKit

protocol OnboardingPageCoordinatorDelegate: class {
    func didFinishLoginPageCoordinator()
}

class OnboardingPageCoordinator: Coordinator {

    private let window: UIWindow?
    private var navigationController: UINavigationController?
    private var onboardingViewController: OnboardingViewController?
    private var onboardingPageCoordinator: OnboardingPageCoordinator?
    private var isLogin: Bool!
    
    weak var delegate: OnboardingPageCoordinatorDelegate?
    
    deinit {
        print("deinit \(String(describing: self))")
    }
    
    init(window: UIWindow, isLogin: Bool) {
        self.window = window
        self.isLogin = isLogin
    }
    
    init(presenter: UINavigationController?, isLogin: Bool) {
        self.navigationController = presenter
        self.isLogin = isLogin
        self.window = nil
    }
    
    func start() {
        self.onboardingViewController = OnboardingViewController()
        self.onboardingViewController?.isLogin = self.isLogin
        self.onboardingViewController?.delegate = self
        if let window = self.window {
            self.navigationController = UINavigationController(rootViewController: self.onboardingViewController!)
            window.rootViewController = self.navigationController
            window.makeKeyAndVisible()
        }
        else {
            self.navigationController?.pushViewController(self.onboardingViewController!, animated: true)
        }
    }
    
}

extension OnboardingPageCoordinator: OnboardingViewControllerDelegate {
    
    func didPressRegister() {
        self.onboardingPageCoordinator = OnboardingPageCoordinator(presenter: self.navigationController, isLogin: false)
        self.onboardingPageCoordinator?.delegate = self
        self.onboardingPageCoordinator?.start()
    }
    
    func didFinishProcess() {
        self.delegate?.didFinishLoginPageCoordinator()
    }
    
    func didFinishOnboardingViewController() {
        self.onboardingPageCoordinator = nil
    }
}

extension OnboardingPageCoordinator: OnboardingPageCoordinatorDelegate {
    func didFinishLoginPageCoordinator() {
        self.onboardingPageCoordinator = nil
        self.delegate?.didFinishLoginPageCoordinator()
    }
}
