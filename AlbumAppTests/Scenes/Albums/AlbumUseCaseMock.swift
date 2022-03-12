//
//  AlbumUseCaseMock.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

@testable import AlbumApp
import RxSwift

final class AlbumUseCaseMock: AlbumUseCaseType {

    // MARK: - getAlbum

    var getAlbumCalled = false
    var getAlbumReturnValue = Observable<[Album]>.just([
        Album(),
        Album()
    ])

    func getAlbum(userID: Int?) -> Observable<[Album]> {
        getAlbumCalled = true
        return getAlbumReturnValue
    }

    // MARK: - getUsers

    var getUsersCalled = false
    var getUsersReturnValue = Observable<[User]>.just([
        User()
    ])

    func getUsers() -> Observable<[User]> {
        getUsersCalled = true
        return getUsersReturnValue
    }

    // MARK: - searchUser

    var searchUserCalled = false
    var searchUserReturnValue = [Album()]

    func searchUser(keyword: String, users: [User], albums: [Album]) -> [Album] {
        searchUserCalled = true
        return searchUserReturnValue
    }
}
