//
//  ImagesListPageCoordinator.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/31/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation
import UIKit

class ImagesListPageCoordinator: Coordinator {
    
    private let window: UIWindow!
    private var navigationController: UINavigationController?
    private var imagesListViewController: ImagesListViewController?
    private var imagePageCoordinator: FullImagePageCoordinator?
    
    deinit {
        print("deinit \(String(describing: self))")
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        self.imagesListViewController = ImagesListViewController()
        self.imagesListViewController?.delegate = self
        self.navigationController = UINavigationController(rootViewController: self.imagesListViewController!)
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    }
}

extension ImagesListPageCoordinator: ImagesListViewControllerDelegate {
    func didSelectImage(viewModel: ImageViewViewModel) {
        self.imagePageCoordinator = FullImagePageCoordinator(presenter: self.navigationController!, viewModel: viewModel)
        self.imagePageCoordinator?.delegate = self
        self.imagePageCoordinator?.start()
    }
}

extension ImagesListPageCoordinator: FullImagePageCoordinatorDelegate {
    func didFinishImagePageCoordinator() {
        self.imagePageCoordinator = nil
    }
}
