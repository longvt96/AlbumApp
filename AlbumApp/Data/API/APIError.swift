//
//  APIError.swift
//  AlbnumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022. All rights reserved.
//

import Foundation
import MGAPIService

struct APIExpiredTokenError: APIError {
    var errorDescription: String? {
        return NSLocalizedString("api.expiredTokenError",
                                 value: "Access token is expired",
                                 comment: "")
    }
}

struct APIResponseError: APIError {
    let statusCode: Int?
    let message: String
    
    var errorDescription: String? {
        return message
    }
}
