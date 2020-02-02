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

class RestClient {
    
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
                                       completion: ((Result<T, Error>) -> Void)?) {
        
        if let apiKey = UserDefaults.standard.string(forKey: Constants.UserDefaults.ApiKey) {
            // TODO: Modify according to api spec
            headers["x-api-key"] = apiKey
            log.debug("x-api-key: \(apiKey)")
        }
        
        AF.request(url,
                   method: method,
                   parameters: data,
                   encoding: JSONEncoding.default,
                   headers: self.headers)
            .responseObject { (response: DataResponse<T>) in
                
                log.debug(response.debugDescription)
                
                switch response.result {
                case .success(let object):
                    if let data = response.data,let error = try? JSONDecoder().decode(APIError.self, from: data) {
                        log.warning("\(error)")
                        completion?(Result.failure(error))
                    } else {
                        log.debug("success: \(String(describing: response.request?.url))")
                        completion?(Result.success(object))
                    }
                case .failure(let error):
                    if let data = response.data,let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
                        log.warning("\(apiError)")
                        completion?(Result.failure(apiError))
                    } else {
                        log.warning("\(error)")
                        completion?(Result.failure(error))
                    }
                }
        }
    }
    
    internal func request<T: Mappable>(url: String,
                                       method: HTTPMethod = .get,
                                       data: [String: Any]? = nil,
                                       completion: ((Result<[T], Error>) -> Void)?) {
        
        if let apiKey = UserDefaults.standard.string(forKey: Constants.UserDefaults.ApiKey) {
            // TODO: Modify according to api spec
            headers["x-api-key"] = apiKey
            log.debug("x-api-key: \(apiKey)")
        }
        
        AF.request(url,
                   method: method,
                   parameters: data,
                   encoding: JSONEncoding.default,
                   headers: self.headers)
            .responseArray { (response: DataResponse<[T]>) in
                
                log.debug(response.debugDescription)
                
                switch response.result {
                case .success(let object):
                    if let data = response.data,let error = try? JSONDecoder().decode(APIError.self, from: data) {
                        log.warning("\(error)")
                        completion?(Result.failure(error))
                    } else {
                        log.debug("success: \(String(describing: response.request?.url))")
                        completion?(Result.success(object))
                    }
                case .failure(let error):
                    if let data = response.data,let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
                        log.warning("\(apiError)")
                        completion?(Result.failure(apiError))
                    } else {
                        log.warning("\(error)")
                        completion?(Result.failure(error))
                    }
                }
        }
    }
}
