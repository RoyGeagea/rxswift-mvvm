//
//  ImageTableViewCell.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/31/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {
    
    static let height: CGFloat = 95
    
    static let nibName = "ImageTableViewCell"
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.imgView.backgroundColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(viewModel: ImageViewViewModel) {
        self.titleLabel.text = viewModel.userName
        self.imgView.kf.cancelDownloadTask()
        if let url = viewModel.previewImageUrl {
            self.imgView.kf.setImage(
                with: url,
                placeholder: nil,
                options: [
                    .transition(.fade(0.5))
                ]) {
                result in
                switch result {
                    case .success:
                                    break
                    case .failure:
                                    break
                }
            }
        }
        else {
            // TODO
        }
    }
    
}
