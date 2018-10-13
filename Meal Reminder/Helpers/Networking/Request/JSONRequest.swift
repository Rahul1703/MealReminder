//
//  JSONRequest.swift
//  Meal Reminder
//
//  Created by Rahul Srivastava on 10/11/18.
//  Copyright © 2018 Rahul Srivastava. All rights reserved.
//

import Foundation

/// JSON Response
public typealias JSONResponse = ((Any) -> ())

/// JSONRequest
public class JSONRequest: Request {
    
    /// Execute JSON Request
    public func execute(success: @escaping JSONResponse, failure: ((ResponseError) -> ())? = nil) {
        NetworkManager.shared.execute(request: self, responseType: .json, success: success, failure: failure)
    }
}

