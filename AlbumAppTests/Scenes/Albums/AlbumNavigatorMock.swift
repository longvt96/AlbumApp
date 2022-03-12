//
//  AlbumNavigatorMock.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

@testable import AlbumApp

final class AlbumNavigatorMock: AlbumNavigatorType {

    // MARK: - toPhotoDetail

    var toPhotoDetailCalled = false

    func toPhotoDetail(albumId: Int) {
        toPhotoDetailCalled = true
    }
}
