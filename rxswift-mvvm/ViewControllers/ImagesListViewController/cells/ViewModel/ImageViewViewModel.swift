//
//  ImageViewViewModel.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/31/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation

class ImageViewViewModel {
    
    private var image: Image!
    
    init(image: Image) {
        self.image = image
    }
}

extension ImageViewViewModel {
    
    var previewImageUrl: URL? {
        guard let url = URL(string: self.image.previewURL ?? "") else {
            return nil
        }
        return url
    }
    
    var imageUrl: URL? {
        guard let url = URL(string: self.image.largeImageURL ?? "") else {
            return nil
        }
        return url
    }
    
    var userName: String {
        return self.image.user ?? "unknown"
    }
    
    var numberOfSections: Int {
        2
    }
    
    func numberOfRows(section: Int) -> Int {
        if section == 0 {
            return 4
        }
        else {
            return 6
        }
    }
    
    func isImageCell(indexPath: IndexPath) -> Bool {
        return indexPath.row == 0 && indexPath.section == 0
    }
    
    func titleForCell(indexPath: IndexPath) -> String {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                return "Image size: \(Units(bytes: Int64(self.image.imageSize ?? 0)).getReadableUnit())"
            }
            else if indexPath.row == 2 {
                return "Type: \(self.image.type ?? "unknown")"
            }
            else {
                return "Tags: \(self.image.tags ?? "unavailable")"
            }
        }
        else {
            if indexPath.row == 0 {
                return "User: \(self.image.user ?? "unknown")"
            }
            else if indexPath.row == 1 {
                return "Views: \(self.image.views ?? 0)"
            }
            else if indexPath.row == 2 {
                return "Likes: \(self.image.likes ?? 0)"
            }
            else if indexPath.row == 3 {
                return "Comments: \(self.image.comments ?? 0)"
            }
            else if indexPath.row == 4 {
                return "Favorites: \(self.image.favorites ?? 0)"
            }
            else {
                return "Downloads: \(self.image.downloads ?? 0)"
            }
        }
    }
    
    func titleForSection(section: Int) -> String {
        if section == 0 {
            return "Section 1"
        }
        else {
            return "Section 2"
        }
    }
}
