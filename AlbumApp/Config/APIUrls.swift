//
//  APIUrls.swift
//  AlbnumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022. All rights reserved.
//

func getAPIURL(path: String) -> String {
    return "https://\(API.Host.domain)\(path)"
}

extension API {
    enum Host {
        static let domain = "jsonplaceholder.typicode.com"
    }

    enum Paths {
        static let albums = "/albums"
        static let users = "/users"
        static let photos = "/photos"
    }

    enum Urls {
        static let albums = getAPIURL(path: Paths.albums)
        static let users = getAPIURL(path: Paths.users)
        static let photos = getAPIURL(path: Paths.photos)
    }
}
