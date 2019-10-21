//
//  AppDelegate.swift
//  Template
//
//  Created by Levente Vig on 2019. 09. 21..
//  Copyright © 2019. levivig. All rights reserved.
//

import SwiftyBeaver
import UIKit

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
     var window: UIWindow?

    // MARK: - Init -
    
    lazy var initializers: [Initializable] = [
        LoggerInitializer()
    ]
    
    // MARK: - Lifecycle -

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializers.forEach { $0.performInitialization() }
        setRoot(wireframe: TabbarWireframe())
        return true
    }
    
    private func setRoot(wireframe: BaseWireframe) {
        let initialController = BaseNavigationController()
        initialController.setNavigationBarHidden(true, animated: false)
        initialController.setRootWireframe(wireframe, animated: true)
        
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            if #available(iOS 13.0, *) {
                self.window?.overrideUserInterfaceStyle = .light
            }
        }
        
        self.window?.rootViewController = initialController
        self.window?.makeKeyAndVisible()
    }
}
