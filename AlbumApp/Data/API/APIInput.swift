//
//  APIInput.swift
//  AlbnumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022. All rights reserved.
//

import Alamofire
import MGAPIService

class APIInput: APIInputBase {
    override init(urlString: String,
                  parameters: [String: Any]?,
                  method: HTTPMethod,
                  requireAccessToken: Bool) {
        super.init(urlString: urlString,
                   parameters: parameters,
                   method: method,
                   requireAccessToken: requireAccessToken)
        self.headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json"
        ]
        self.user = nil
        self.password = nil
    }
}
