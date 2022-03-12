//
//  Photo.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import ObjectMapper

struct Photo {
    var albumID: Int = 0
    var id: Int = 0
    var title: String = ""
    var url: String = ""
    var thumbnailURL: String = ""
}

extension Photo: Then { }

extension Photo: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        albumID <- map["albumId"]
        id <- map["id"]
        title <- map["title"]
        url <- map["url"]
        thumbnailURL <- map["thumbnailUrl"]
    }
}

extension Photo: Hashable { }
