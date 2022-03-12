//
//  GettingUser.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import Foundation

protocol GettingUser {
    var userGateway: UserGatewayType { get }
}

extension GettingUser {
    func getUsers() -> Observable<[User]> {
        userGateway.getUsers()
    }
}
