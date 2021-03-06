//
//  TabbarWireframe.swift
//  citychat
//
//  Created by Levente Vig on 2019. 07. 12..
//  Copyright (c) 2019. CodeYard. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class TabbarWireframe: BaseWireframe {

    // MARK: - Private properties -

    private let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)

    // MARK: - Module setup -

    init(selctedTab: Int = 0) {
        let moduleViewController = storyboard.instantiateViewController(ofType: TabbarViewController.self)
        super.init(viewController: moduleViewController)
        
        let interactor = TabbarInteractor()
        let presenter = TabbarPresenter(view: moduleViewController, interactor: interactor, wireframe: self, selectedTab: selctedTab)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension TabbarWireframe: TabbarWireframeInterface {
}
