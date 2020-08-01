//
//  Strings.swift
//  Kodmus
//
//  Created by Roy Geagea on 4/29/19.
//  Copyright © 2019 KODMUS. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    func containsSpecialCharacter() -> Bool {
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format: "SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    func isOnlyAlphabets() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z].*", options: [])
            if regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) != nil {
                return false
            }
            else {
                return true
            }
        }
        catch {
            return true
        }
    }
    
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

}
