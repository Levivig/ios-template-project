//
//  BaseResponse.swift
//  citychat
//
//  Created by Levente Vig on 2019. 07. 29..
//  Copyright © 2019. CodeYard. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse: Mappable, Encodable {
    
    var isSuccess: Bool?
    
    required init?(map: Map) {
        
    }
    
    init?() {
        
    }
    
    func mapping(map: Map) {
        fatalError("Implementation pending...")
    }
}
