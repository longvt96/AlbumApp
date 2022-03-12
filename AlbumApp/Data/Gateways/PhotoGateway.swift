//
//  PhotoGateway.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import Foundation

protocol PhotoGatewayType {
    func getPhotos(albumId: Int) -> Observable<[Photo]>
}

struct PhotoGateway: PhotoGatewayType {
    func getPhotos(albumId: Int) -> Observable<[Photo]> {
        let input = API.GetPhotoListInput(albumId: albumId)
        return API.shared.getPhotoList(input)
    }
}
