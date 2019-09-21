//
//  TabbarProtocol.swift
//  Template
//
//  Created by Levente Vig on 2019. 09. 21..
//  Copyright © 2019. levivig. All rights reserved.
//

import UIKit

protocol TabbarProtocol {
    var tabbarImage: UIImage? { get }
    var selectedTabbarImage: UIImage? { get }
    
    func setTabbarItem()
}
