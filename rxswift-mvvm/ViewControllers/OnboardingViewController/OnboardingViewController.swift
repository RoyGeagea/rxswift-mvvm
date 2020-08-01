//
//  LoginViewController.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/30/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol OnboardingViewControllerDelegate: class {
    func didPressRegister()
    func didFinishProcess()
    func didFinishOnboardingViewController()
}

class OnboardingViewController: UIViewController {
    
    private let validColor = UIColor.green
    private let invalidColor = UIColor.red
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var passwordMessageLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var ageMessageLabel: UILabel!
    
    var registerButton: UIBarButtonItem?
    
    weak var delegate: OnboardingViewControllerDelegate?
    
    var viewModel: OnboardingViewViewModel!
    var disposeBag: DisposeBag?
    
    var isLogin = true
    
    deinit {
        print("deinit \(String(describing: self))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.viewModel = OnboardingViewViewModel(loginRepository: UserMockRepository())
        
        self.emailTextField.layer.borderWidth = 2
        self.emailTextField.layer.borderColor = invalidColor.cgColor
        
        self.passwordTextField.layer.borderWidth = self.emailTextField.layer.borderWidth
        self.passwordTextField.layer.borderColor = self.emailTextField.layer.borderColor
        
        self.ageTextField.layer.borderWidth = self.emailTextField.layer.borderWidth
        self.ageTextField.layer.borderColor = self.emailTextField.layer.borderColor
        
        self.ageTextField.isHidden = self.isLogin
        self.ageMessageLabel.isHidden = self.isLogin

        self.proceedButton.isEnabled = false
        if self.isLogin {
            self.proceedButton.setTitle("Login", for: .normal)
            self.title = "Login"
            self.registerButton = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(didPressRegister))
            navigationItem.rightBarButtonItem = self.registerButton
        }
        else {
            self.proceedButton.setTitle("Signup", for: .normal)
            self.title = "Register"
        }
        
        self.activityIndicator.isHidden = true
        self.activityIndicator.startAnimating()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.disposeBag = DisposeBag()
        
        let emailObservable = self.emailTextField.rx.text.asObservable()
        let passwordObservable = self.passwordTextField.rx.text.asObservable()
        let ageObservable = self.ageTextField.rx.text.asObservable()

        emailObservable.subscribe(onNext: { (text) in
            self.emailTextField.layer.borderColor = self.viewModel.isValidEmail(text: text) ? self.validColor.cgColor : self.invalidColor.cgColor
        })
        .disposed(by: disposeBag!)
        
        passwordObservable.subscribe(onNext: { (text) in
            self.passwordTextField.layer.borderColor = self.viewModel.isValidPassword(text: text) ? self.validColor.cgColor : self.invalidColor.cgColor
        })
        .disposed(by: disposeBag!)
        
        ageObservable.subscribe(onNext: { (text) in
            self.ageTextField.layer.borderColor = self.viewModel.isValidAge(age: text) ? self.validColor.cgColor : self.invalidColor.cgColor
        })
        .disposed(by: disposeBag!)
        
        if self.isLogin {
            Observable.combineLatest(emailObservable, passwordObservable) { (email, password) -> Bool in
                return self.viewModel.isValidEmail(text: email) && self.viewModel.isValidPassword(text: password)
            }
            .subscribe(onNext: { (isValid) in
                self.proceedButton.isEnabled = isValid
            })
            .disposed(by: disposeBag!)
        }
        else {
            Observable.combineLatest(emailObservable, passwordObservable, ageObservable) { (email, password, age) -> Bool in
                return self.viewModel.isValidEmail(text: email) && self.viewModel.isValidPassword(text: password) && self.viewModel.isValidAge(age: age)
            }
            .subscribe(onNext: { (isValid) in
                self.proceedButton.isEnabled = isValid
            })
            .disposed(by: disposeBag!)
        }
        
        viewModel.emptyResponseObservable.subscribe(onNext: { [weak self] (_) in
            guard let `self` = self else {
                return
            }
            self.setIsNotLoading()
            self.delegate?.didFinishProcess()
        })
        .disposed(by: disposeBag!)
        
        viewModel.errorObservable.subscribe(onNext: { [weak self] error in
            guard let `self` = self else {
                return
            }
            self.setIsNotLoading()
            UIHelper.showMessage(message: error)
        })
        .disposed(by: disposeBag!)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.disposeBag = nil
    }
    
    // MARK: - Actions
    
    @IBAction func didPressProceed(_ sender: UIButton) {
        self.setIsLoading()
        self.viewModel.login(email: self.emailTextField.text!, password: self.passwordTextField.text!)
    }
    
    @objc func didPressRegister() {
        self.delegate?.didPressRegister()
    }
    
    // MARK: - Helpers
    
    func setIsLoading() {
        self.activityIndicator.isHidden = false
        self.proceedButton.isHidden = true
    }
    
    func setIsNotLoading() {
        self.activityIndicator.isHidden = true
        self.proceedButton.isHidden = false
    }

}

extension OnboardingViewController: UINavigationControllerDelegate {
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        if parent == nil {
            self.delegate?.didFinishOnboardingViewController()
        }
    }
}
