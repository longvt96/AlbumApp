//
//  UserTest.swift
//  AlbumAppTests
//
//  Created by Long Vu on 12/03/2022.
//

import XCTest
@testable import AlbumApp

final class UserTest: XCTestCase {

    func test_mapping() {
        let json: [String: Any] = [
            "id": 10,
            "name": "Clementina DuBuque",
            "username": "Moriah.Stanton",
            "email": "Rey.Padberg@karina.biz"
        ]
        let user = User(JSON: json)
        
        XCTAssertNotNil(user)
        XCTAssertEqual(user?.id, json["id"] as? Int)
        XCTAssertEqual(user?.name, json["name"] as? String)
        XCTAssertEqual(user?.username, json["username"] as? String)
        XCTAssertEqual(user?.email, json["email"] as? String)
    }
}
