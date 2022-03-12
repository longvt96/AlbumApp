//
//  GettingPhoto.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import Foundation

protocol GettingPhoto {
    var photoGateway: PhotoGatewayType { get }
}

extension GettingPhoto {
    func getPhotoList(albumId: Int) -> Observable<[Photo]> {
        photoGateway.getPhotos(albumId: albumId)
    }
}
