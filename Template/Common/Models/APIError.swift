//
//  APIError.swift
//  Template
//
//  Created by Levente Vig on 2020. 02. 02..
//  Copyright © 2020. levivig. All rights reserved.
//

import Foundation

class APIError: Codable, LocalizedError {
    
    // TODO: Modify according to API
    
    var name: String = ""
    var message: String = ""
    var code: Int = 0
    var type: String = ""
    
    var errorDescription: String? {
        return type
    }
}
