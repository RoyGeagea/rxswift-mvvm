//
//  Logger.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/30/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation

protocol Logger {
    func startLogging()
    func log(_ string: String)
    func getLogsFiles() -> Data?
}
