//
//  AlbumGateway.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import Foundation

protocol AlbumGatewayType {
    func getAlbum(userID: Int?) -> Observable<[Album]>
}

struct AlbumGateway: AlbumGatewayType {
    func getAlbum(userID: Int?) -> Observable<[Album]> {
        let input = API.GetAlbumListInput(userId: userID)
        return API.shared.getAlbumList(input)
    }
}
