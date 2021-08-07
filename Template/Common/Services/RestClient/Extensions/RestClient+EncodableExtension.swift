//
//  RestClient+EncodableExtension.swift
//  Template
//
//  Created by Levente Vig on 2021. 08. 07..
//  Copyright © 2021. levivig. All rights reserved.
//

import Foundation

extension Encodable {
    var safeJson: String {
        let encoder = JSONEncoder()
        if #available(iOS 13.0, *) {
            encoder.outputFormatting = [.sortedKeys, .withoutEscapingSlashes]
        } else {
            encoder.outputFormatting = [.sortedKeys]
        }
        return (try? encoder.encode(self).string(encoding: .utf8)) ?? ""
    }
}
