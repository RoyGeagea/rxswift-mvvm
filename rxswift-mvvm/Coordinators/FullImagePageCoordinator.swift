//
//  ImagePageCoordinator.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/31/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation
import UIKit

protocol FullImagePageCoordinatorDelegate: class {
    func didFinishImagePageCoordinator()
}

class FullImagePageCoordinator: Coordinator {
    
    private var presenter: UINavigationController?
    private var viewModel: ImageViewViewModel?
    private var fullImageViewController: FullImageViewController?
    
    weak var delegate: FullImagePageCoordinatorDelegate?
    
    deinit {
        print("deinit \(String(describing: self))")
    }
    
    init(presenter: UINavigationController, viewModel: ImageViewViewModel) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    func start() {
        self.fullImageViewController = FullImageViewController()
        self.fullImageViewController?.viewModel = self.viewModel
        self.fullImageViewController?.delegate = self
        self.presenter?.pushViewController(fullImageViewController!, animated: true)
    }
}

extension FullImagePageCoordinator: FullImageViewControllerDelegate {
    func didFinishFullImageViewController() {
        self.delegate?.didFinishImagePageCoordinator()
    }
}
