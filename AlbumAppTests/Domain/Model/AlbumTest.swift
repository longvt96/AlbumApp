//
//  AlbumTest.swift
//  AlbumAppTests
//
//  Created by Long Vu on 12/03/2022.
//

import XCTest
@testable import AlbumApp

final class AlbumTest: XCTestCase {

    func test_mapping() {
        let json: [String: Any] = [
            "userId": 1,
            "id": 1,
            "title": "quidem molestiae enim"
        ]
        let album = Album(JSON: json)
        
        XCTAssertNotNil(album)
        XCTAssertEqual(album?.id, json["id"] as? Int)
        XCTAssertEqual(album?.title, json["title"] as? String)
        XCTAssertEqual(album?.userID, json["userId"] as? Int)
    }
}
