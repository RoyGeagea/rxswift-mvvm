//
//  ImagesListViewController.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/31/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol ImagesListViewControllerDelegate: class {
    func didSelectImage(viewModel: ImageViewViewModel)
}

class ImagesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var viewModel: ImagesListViewViewModel!
    let disposeBag: DisposeBag? = DisposeBag()
    
    weak var delegate: ImagesListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Pixabay"
        
        viewModel = ImagesListViewViewModel(imagesRepository: ImagesRemoteRepository(networkManeger: NetworkManager.sharedInstance), userRepository: UserMockRepository())
        
        viewModel.images.drive(onNext: {[unowned self] (_) in
            self.tableView.reloadData()
        }).disposed(by: disposeBag!)
        
        viewModel.isFetching.drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag!)
        
        viewModel.isFetching.drive(onNext: { (isFetching) in
            self.activityIndicator.isHidden = !isFetching
        })
        .disposed(by: disposeBag!)
                
        viewModel.error.drive(onNext: {[unowned self] (error) in
            self.infoLabel.isHidden = !self.viewModel.hasError
            self.infoLabel.text = error
        }).disposed(by: disposeBag!)
        
        setupTableView()
        
        self.viewModel.fetchImages()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: ImageTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ImageTableViewCell.nibName)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfImages
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.nibName, for: indexPath) as! ImageTableViewCell
        cell.setupCell(viewModel: viewModel.viewModelForImage(index: indexPath.row))
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ImagesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectImage(viewModel: viewModel.viewModelForImage(index: indexPath.row))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ImageTableViewCell.height
    }
}
