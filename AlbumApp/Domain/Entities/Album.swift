//
//  Album.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import ObjectMapper

struct Album {
    var userID: Int = 0
    var id: Int = 0
    var title: String = ""
}

extension Album: Then { }

extension Album: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        userID <- map["userId"]
        id <- map["id"]
        title <- map["title"]
    }
}
