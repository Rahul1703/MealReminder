//
//  DataModelRequest.swift
//  Meal Reminder
//
//  Created by Rahul Srivastava on 10/11/18.
//  Copyright © 2018 Rahul Srivastava. All rights reserved.
//

import Foundation

/// DataModelResponse
public typealias DataModelResponse<T> = ((T) -> ())

/// Response Error
public typealias ResponseError = (code: Int, message: String)

/// DataModelRequest
public class DataModelRequest<T: Codable>: Request {
    
    /// Execute request
    public func execute(success: @escaping DataModelResponse<T>, failure: ((ResponseError) -> ())? = nil) {
        
        NetworkManager.shared.execute(request: self, responseType: .dataModel, success: { [weak self] (response) in
            
            // convert to models
            if let data = (response as? Data) {
                self?.convertDataToObjects(data, success: success, failure: failure)
            }
            
        }, failure: failure)
    }
}

// MARK: - Private
extension DataModelRequest {
    
    /// Convert data to specified objects
    private func convertDataToObjects(_ data: Data, success: @escaping ((T) -> ()), failure: ((ResponseError) -> ())?) {
        
        // convert to specified type
        let result = try? JSONDecoder().decode(T.self, from: data)
        
        DispatchQueue.main.async {
            
            // success
            if let result = result {
                success(result)
            }
            
            // error
            else if let failure = failure {
                failure(ResponseError(kModelConversionErrCode, mErrorInModelConversion))
            }
        }
    }
}
