//
//  FullImageViewController.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/31/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import UIKit

protocol FullImageViewControllerDelegate: class {
    func didFinishFullImageViewController()
}

class FullImageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ImageViewViewModel!
    
    weak var delegate: FullImageViewControllerDelegate?
    
    deinit {
        print("deinit \(String(describing: self))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupTableView()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 40
        tableView.register(UINib(nibName: FullImageTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: FullImageTableViewCell.nibName)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.delegate?.didFinishFullImageViewController()
    }
    
}

// MARK: - UITableViewDataSource

extension FullImageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isImageCell(indexPath: indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: FullImageTableViewCell.nibName, for: indexPath) as! FullImageTableViewCell
            cell.setupCell(image: self.viewModel.imageUrl)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = self.viewModel.titleForCell(indexPath: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension FullImageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.isImageCell(indexPath: indexPath) {
            return FullImageTableViewCell.height
        }
        else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.titleForSection(section: section)
    }
}

