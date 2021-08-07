//
//  RestClient+DataExtension.swift
//  Template
//
//  Created by Levente Vig on 2021. 08. 07..
//  Copyright © 2021. levivig. All rights reserved.
//

import Foundation

extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else { return nil }
        
        return prettyPrintedString
    }
}
