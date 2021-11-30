//
//  TabbarInterfaces.swift
//  Template
//
//  Created by Levente Vig on 2019. 07. 12..
//  Copyright (c) 2019. CodeYard. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol TabbarWireframeInterface: WireframeInterface {
}

protocol TabbarViewInterface: ViewInterface {
    func set(controllers: [UIViewController])
    func select(tab: Int)
}

protocol TabbarPresenterInterface: PresenterInterface {
    func setupViewControllers() -> [UIViewController]
}

protocol TabbarInteractorInterface: InteractorInterface {
}
