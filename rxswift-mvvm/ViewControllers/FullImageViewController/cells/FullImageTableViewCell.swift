//
//  FullImageTableViewCell.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/31/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import UIKit
import Kingfisher

class FullImageTableViewCell: UITableViewCell {

    static let nibName = "FullImageTableViewCell"
    static let height: CGFloat = (9/16) * UIScreen.main.bounds.width
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
        self.imgView.backgroundColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(image: URL?) {
        self.imgView.kf.cancelDownloadTask()
        if let url = image {
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
