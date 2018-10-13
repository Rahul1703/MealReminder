//
//  Request.swift
//  Meal Reminder
//
//  Created by Rahul Srivastava on 10/11/18.
//  Copyright © 2018 Rahul Srivastava. All rights reserved.
//

import Foundation

/// Types of Response
public enum ResponseType {
    case json, dataModel
}

/// Request
open class Request {
    
    /// URL
    public var url: String
    
    /// HTTP Method
    public var method: HTTPMethod = .GET
    
    /// Requst Headers
    public var headers: [String: String]?
    
    /// Request Parameters
    public var parameters: [String: Any]?
    
    /// Response Keypath
    public var responeKeyPath: String?
    
    // MARK: - Init
    public init(url: String, method: HTTPMethod, headers: [String: String]? = nil, parameters: [String: Any]? = nil, responeKeyPath: String? = nil) {
        self.method = method
        self.url = url
        self.headers = headers
        self.parameters = parameters
        self.responeKeyPath = responeKeyPath
    }
    
    public convenience init(url: String, responeKeyPath: String) {
        self.init(url: url, method: .GET, responeKeyPath: responeKeyPath)
    }
    
    public convenience init(url: String) {
        self.init(url: url, method: .GET)
    }
}

