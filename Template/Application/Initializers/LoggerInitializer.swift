//
//  LoggerInitializer.swift
//  Template
//
//  Created by Levente Vig on 2019. 09. 21..
//  Copyright © 2019. levivig. All rights reserved.
//

import Foundation
import SwiftyBeaver

class LoggerInitializer: Initializable {
    func performInitialization() {
//        let cloud = SBPlatformDestination(appID: "zLg79p",
//                                          appSecret: "mdp6ddyctv9fggymftu9eERnCx93iphm",
//                                          encryptionKey: "iyrurq3pbPpbhcnagx4kdzgzypcQciBp")
//        log.addDestination(cloud)
        let console = ConsoleDestination()
        log.addDestination(console)
    }
}
