//
//  RestClient.swift
//  Template
//
//  Created by Levente Vig on 2019. 09. 21..
//  Copyright © 2019. levivig. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import Foundation
import ObjectMapper

class RestClient: DataProvider {
    
    // MARK: Singleton
    static let shared = RestClient()
    private init() {}
    
    // MARK: - Private properties -
    
    private var headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    // MARK: - Requests -
    
    internal func request<T: Mappable>(url: String,
                                       method: HTTPMethod = .get,
                                       data: [String: Any]? = nil,
                                       completion: ((T?, Error?) -> Void)?) {
        AF.request(url,
                   method: method,
                   parameters: data,
                   encoding: JSONEncoding.default,
                   headers: self.headers)
            .validate(statusCode: 200..<300)
            .responseObject { (response: DataResponse<T>) in
                
                log.verbose("Request: \(String(describing: response.request))")   // original url request
                log.verbose("Response: \(String(describing: response.response))") // http url response
                log.verbose("Result: \(response.result)")                         // response serialization result
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    log.debug("Data: \(utf8Text)")
                }
                
                switch response.result {
                case .success(let data):
                    log.debug("Data: \(data)")
                    completion?(data, nil)
                case .failure(let error):
                    log.warning("\(error)")
                    completion?(nil, error)
                }
        }
    }
    
    internal func request<T: Mappable>(url: String,
                                       method: HTTPMethod = .get,
                                       data: [String: Any]? = nil,
                                       completion: (([T]?, Error?) -> Void)?) {
        AF.request(url,
                   method: method,
                   parameters: data,
                   encoding: JSONEncoding.default,
                   headers: self.headers)
            .validate(statusCode: 200..<300)
            .responseArray { (response: DataResponse<[T]>) in
                
                log.verbose("Request: \(String(describing: response.request))")   // original url request
                log.verbose("Response: \(String(describing: response.response))") // http url response
                log.verbose("Result: \(response.result)")                         // response serialization result
                
                switch response.result {
                case .success(let data):
                    log.debug("Data: \(data)")
                    completion?(data, nil)
                case .failure(let error):
                    log.warning("\(error)")
                    completion?(nil, error)
                }
        }
    }
}
