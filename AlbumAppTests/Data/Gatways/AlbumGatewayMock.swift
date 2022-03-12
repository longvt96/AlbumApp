//
//  AlbumGatewayMock.swift
//  AlbumAppTests
//
//  Created by Long Vu on 12/03/2022.
//

@testable import AlbumApp
import UIKit

final class AlbumGatewayMock: AlbumGatewayType {

    // MARK: - getAlbum

    var getAlbumCalled = false
    var getAlbumReturnValue = Observable<[Album]>.just([
        Album()
    ])

    func getAlbum(userID: Int?) -> Observable<[Album]> {
        getAlbumCalled = true
        return getAlbumReturnValue
    }
}
