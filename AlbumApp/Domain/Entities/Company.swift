//
//  Company.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import ObjectMapper

struct Company {
    var name: String = ""
    var catchPhrase: String = ""
    var bs: String = ""
}

extension Company: Then { }

extension Company: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        catchPhrase <- map["catchPhrase"]
        bs <- map["bs"]
    }
}
