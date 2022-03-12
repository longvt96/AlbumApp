//
//  PhotoDetailUseCaseMock.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

@testable import AlbumApp
import RxSwift

final class PhotoDetailUseCaseMock: PhotoDetailUseCaseType {

    // MARK: - getPhotoList

    var getPhotoListCalled = false
    var getPhotoListReturnValue = Observable<[Photo]>.just([
        Photo()
    ])

    func getPhotoList(albumId: Int) -> Observable<[Photo]> {
        getPhotoListCalled = true
        return getPhotoListReturnValue
    }
}
