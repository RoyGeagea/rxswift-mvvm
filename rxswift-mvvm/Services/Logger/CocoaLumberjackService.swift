//
//  LoggerManager.swift
//  Kodmus
//
//  Created by Roy Geagea on 7/25/19.
//  Copyright © 2019 KODMUS. All rights reserved.
//

import Foundation
import CocoaLumberjack

class CocoaLumberjackService: NSObject, Logger {

    public let fileLogger: DDFileLogger = DDFileLogger()
    
    class var shared: CocoaLumberjackService {
        struct Singleton {
            static let instance = CocoaLumberjackService()
        }
        return Singleton.instance
    }
    
    private override init() {}
    
    func startLogging() {
        DDLog.add(DDOSLogger.sharedInstance)
                
        // File logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)
        fileLogger.logFileManager.maximumNumberOfLogFiles = 1
        DDLog.add(fileLogger, with: .all)
    }
    
    func log(_ string: String) {
        DDLogInfo(string)
    }
    
    func getLogsFiles() -> Data? {
        let logURLs = self.fileLogger.logFileManager.sortedLogFilePaths
            .map { URL.init(fileURLWithPath: $0, isDirectory: false) }
        
        var logsDict: [String: Data] = [:] // File Name : Log Data
        logURLs.forEach { (fileUrl) in
            guard let data = try? Data(contentsOf: fileUrl) else { return }
            logsDict[fileUrl.lastPathComponent] = data
        }
        
        var logDataToReturn: Data?
        for (_, logData)  in logsDict {
            logDataToReturn = logData
        }
        return logDataToReturn
    }
}
