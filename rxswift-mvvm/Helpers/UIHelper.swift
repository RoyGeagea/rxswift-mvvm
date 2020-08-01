//
//  UIHelper.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/31/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation
import SwiftMessages

class UIHelper: NSObject {
    
    class func showMessage(message: String) {
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.success)
            
        warning.configureContent(title: message, body: "", iconText: "")
        warning.button?.isHidden = true
        warning.backgroundView.backgroundColor = .red
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        warningConfig.preferredStatusBarStyle = .lightContent
        
        SwiftMessages.show(config: warningConfig, view: warning)
    }
}
