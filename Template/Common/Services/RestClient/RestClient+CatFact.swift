//
//  RestClient+CatFact.swift
//  Template
//
//  Created by Levente Vig on 2021. 08. 07..
//  Copyright © 2021. levivig. All rights reserved.
//

import Foundation
import PromiseKit

struct CatFact: Codable {
    var fact: String
    var length: Int
}

extension RestClient {
    
    /// Get a promise containing the mapped object
    ///
    /// Usage:
    /// RestClient.shared.getCatFact()
    /// .done { fact in
    ///     log.debug(fact)
    /// }.catch { error in
    ///     log.debug(error)
    /// }
    ///
    func getCatFact() -> Promise<CatFact> {
        let url = "https://catfact.ninja/fact"
        
        return request(url: url)
    }
    
    /// Get a completion block containing the result or an error
    ///
    /// Usage:
    /// RestClient.shared.getCatFact { result in
    ///     switch result {
    ///     case .success(let fact):
    ///         log.debug(fact)
    ///     case .failure(let error):
    ///         log.debug(error)
    ///     }
    /// }
    ///
    func getCatFact(completion: ((Swift.Result<CatFact, Error>) -> Void)?) {
        let url = "https://catfact.ninja/fact"
        request(url: url, completion: completion)
    }
}
