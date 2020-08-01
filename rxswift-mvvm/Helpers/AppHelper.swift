//
//  Helper.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/30/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation

class AppHelper: NSObject {

    static func loadStubFromBundle(withName name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder().self)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        return try! Data(contentsOf: url!)
    }
    
}
