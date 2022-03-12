//
//  PhotoGatewayMock.swift
//  AlbumAppTests
//
//  Created by Long Vu on 12/03/2022.
//

@testable import AlbumApp
import UIKit


final class PhotoGatewayMock: PhotoGatewayType {

    // MARK: - getPhotos

    var getPhotosCalled = false
    var getPhotosReturnValue = Observable<[Photo]>.just([
        Photo()
    ])

    func getPhotos(albumId: Int) -> Observable<[Photo]> {
        getPhotosCalled = true
        return getPhotosReturnValue
    }
}
