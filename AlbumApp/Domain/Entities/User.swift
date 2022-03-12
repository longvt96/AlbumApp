//
//  User.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import ObjectMapper

struct User {
    var id: Int = 0
    var name: String = ""
    var username: String = ""
    var email: String = ""
    var address: Address?
    var phone: String = ""
    var website: String = ""
}

extension User: Then { }

extension User: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        username <- map["username"]
        email <- map["email"]
        address <- map["address"]
        phone <- map["phone"]
        website <- map["website"]
    }
}
