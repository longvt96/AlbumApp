//
//  GettingAlbum.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import Foundation

protocol GettingAlbum {
    var albumGateWay: AlbumGatewayType { get }
}

extension GettingAlbum {
    func getAlbum(userID: Int?) -> Observable<[Album]> {
        albumGateWay.getAlbum(userID: userID)
    }
}
