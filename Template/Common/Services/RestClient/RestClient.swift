//
//  RestClient.swift
//  Template
//
//  Created by Levente Vig on 2019. 09. 21..
//  Copyright © 2019. levivig. All rights reserved.
//

import Foundation
import PromiseKit
import SwifterSwift

class RestClient {
    
    // MARK: Singleton
    static let shared = RestClient()
    private init() {}
    
    enum HTTPMethod: String {
        case get = "GET"
        case head = "HEAD"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case connect = "CONNECT"
        case options = "OPTIONS"
        case trace = "TRACE"
        case patch = "PATCH"
    }
    
    // MARK: - Private properties -
    
    private var configuration: URLSessionConfiguration {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20.0
        sessionConfig.timeoutIntervalForResource = 30.0
        return sessionConfig
    }
    
    private var headers: [String: String] = [
        "Content-Type": "application/json"
    ]
    
    internal func updateAuthToken(_ token: String) {
        headers["authorization"] = token
    }
    
    func getAuthToken() -> String {
        headers["authorization"] ?? ""
    }
    
    // MARK: - Requests -
    
    func getSessionLenght() -> Double {
        Double.random(in: 60..<120)
    }
    
    // MARK: - Result completion block -
    
    internal func request<T: Codable>(url: String,
                                      method: HTTPMethod = .get,
                                      data: String? = nil,
                                      completion: ((Swift.Result<T, Error>) -> Void)?) {
        guard let url = URL(string: url) else {
            completion?(Swift.Result.failure(URLError(.badURL)))
            return
        }
        log.debug(url.absoluteString)
        var request: URLRequest = URLRequest(url: url)
        if let data = data {
            request.httpBody = data.data(using: .utf8)
        }
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = self.headers
        
        URLSession(configuration: configuration).dataTask(with: request) { data, response, error in
            log.debug(self.getDebugDescription(request: request, response: response, data: data))
            if let error = error {
                completion?(Swift.Result.failure(error))
                return
            }
            self.handleDataResponse(result: (data, response), completion: completion)
        }.resume()
    }
    
    private func handleDataResponse<T: Codable>(result: (data: Data?, response: URLResponse?), completion: ((Swift.Result<T, Error>) -> Void)?) {
        guard let data = result.data else {
            completion?(Swift.Result.failure(URLError(.unknown)))
            return
        }
        let decoder = JSONDecoder()
        if let object = try? decoder.decode(APIError.self, from: data) {
            completion?(Swift.Result.failure(object))
        } else if let object = try? decoder.decode(T.self, from: data) {
            completion?(Swift.Result.success(object))
        } else {
            completion?(Swift.Result.failure(URLError(.cannotParseResponse)))
        }
    }
    
    // MARK: - Promise -
    
    internal func request<T: Codable>(url: String,
                                      method: HTTPMethod = .get,
                                      data: String? = nil) -> Promise<T> {
        guard let url = URL(string: url) else { return Promise(error: URLError(.badURL)) }
        var request: URLRequest = URLRequest(url: url)
        if let data = data {
            request.httpBody = data.data(using: .utf8)
        }
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = self.headers
        
        return URLSession(configuration: configuration).dataTask(.promise, with: request)
            .map { result in
                log.debug(self.getDebugDescription(request: request, response: result.response, data: result.data))
                return try self.handleDataResponse(result: result)
            }.recover { error -> Promise<T> in
                throw error
            }
    }
    
    private func handleDataResponse<T: Codable>(result: (data: Data, response: URLResponse)) throws -> T {
        debugPrint()
        let decoder = JSONDecoder()
        if let object = try? decoder.decode(APIError.self, from: result.data) {
            throw object
        } else if let object = try? decoder.decode(T.self, from: result.data) {
            return object
        }
        throw URLError(.cannotParseResponse)
    }
    
    // MARK: - Logging -
    
    private func getDebugDescription(request: URLRequest?, response: URLResponse?, data: Data?) -> String {
        let requestDescription = request.map { "\($0.httpMethod ?? "Unknown") \($0)" } ?? "nil"
        let headers = request?.allHTTPHeaderFields?.map { "\($0): \($1)" }.joined(separator: "\n") ?? "None"
        let code = (response as? HTTPURLResponse)?.statusCode
        let requestBody = request?.httpBody?.prettyPrintedJSONString ?? "None"
        let responseBody = data?.prettyPrintedJSONString ?? "None"
        
        return """
            [Request]: \(requestDescription)
            [Headers]: \n\(headers)
            [Status Code]: \(code ?? 0)
            [Request Body]: \n\(requestBody)
            [Response Body]: \n\(responseBody)
            [Data]: \(data?.description ?? "None")
            """
    }
    
}
