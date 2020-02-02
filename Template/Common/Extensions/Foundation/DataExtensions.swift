//
//  DataExtensions.swift
//  Template
//
//  Created by Levente Vig on 2020. 02. 02..
//  Copyright © 2020. levivig. All rights reserved.
//

import Foundation

extension Data {
    func tokenString() -> String {
        let parts = self.map { data in String(format: "%02.2hhx", data) }
        return parts.joined()
    }
}
