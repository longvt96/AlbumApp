//
//  PhotoTest.swift
//  AlbumAppTests
//
//  Created by Long Vu on 12/03/2022.
//

import XCTest
@testable import AlbumApp

final class PhotoTest: XCTestCase {

    func test_mapping() {
        let json: [String: Any] = [
            "albumId": 1,
            "id": 1,
            "title": "accusamus beatae ad facilis cum similique qui sunt",
            "url": "https://via.placeholder.com/600/92c952",
            "thumbnailUrl": "https://via.placeholder.com/150/92c952"
        ]
        let photo = Photo(JSON: json)
        
        XCTAssertNotNil(photo)
        XCTAssertEqual(photo?.id, json["id"] as? Int)
        XCTAssertEqual(photo?.albumID, json["albumId"] as? Int)
        XCTAssertEqual(photo?.title, json["title"] as? String)
        XCTAssertEqual(photo?.url, json["url"] as? String)
        XCTAssertEqual(photo?.thumbnailURL, json["thumbnailUrl"] as? String)
    }
}

