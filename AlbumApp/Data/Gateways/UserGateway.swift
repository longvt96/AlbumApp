//
//  UserGateway.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import Foundation

protocol UserGatewayType {
    func getUsers() -> Observable<[User]>
}

struct UserGateway: UserGatewayType {
    func getUsers() -> Observable<[User]> {
        let input = API.GetUserListInput()
        return API.shared.getUserList(input)
    }
}
