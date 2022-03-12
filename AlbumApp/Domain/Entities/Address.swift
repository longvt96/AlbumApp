//
//  Address.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import ObjectMapper

struct Address {
    var street: String = ""
    var suite: String = ""
    var city: String = ""
    var zipcode: String = ""
    var geo: Geo?
}

extension Address: Then { }

extension Address: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        street <- map["street"]
        suite <- map["suite"]
        city <- map["city"]
        zipcode <- map["zipcode"]
        geo <- map["geo"]
    }
}

struct Geo {
    var lat: String = ""
    var long: String = ""
}

extension Geo: Then { }

extension Geo: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        lat <- map["lat"]
        long <- map["long"]
    }
}
