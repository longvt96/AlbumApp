//
//  UserGatewayMock.swift
//  AlbumAppTests
//
//  Created by Long Vu on 12/03/2022.
//

@testable import AlbumApp
import UIKit

final class UserGatewayMock: UserGatewayType {

    // MARK: - getUsers

    var getUsersCalled = false
    var getUsersReturnValue = Observable<[User]>.just([
        User()
    ])

    func getUsers() -> Observable<[User]> {
        getUsersCalled = true
        return getUsersReturnValue
    }
}
