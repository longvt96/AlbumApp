//
//  AlbumUseCase.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

import RxSwift

protocol AlbumUseCaseType {
    func getAlbum(userID: Int?) -> Observable<[Album]>
    func getUsers() -> Observable<[User]>
    func searchUser(keyword: String, users: [User], albums: [Album]) -> [Album]
}

struct AlbumUseCase: AlbumUseCaseType, GettingAlbum, GettingUser {
    var userGateway: UserGatewayType
    var albumGateWay: AlbumGatewayType

    func searchUser(keyword: String, users: [User], albums: [Album]) -> [Album] {
        let searchUsersID = users.filter {
            $0.name.contains(keyword) || $0.name.contains(keyword.lowercased())
        }.map { $0.id }
        return albums.filter { searchUsersID.contains($0.userID) }
    }
}
