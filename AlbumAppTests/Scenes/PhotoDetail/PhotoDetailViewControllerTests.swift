//
//  PhotoDetailViewControllerTests.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

@testable import AlbumApp
import Reusable
import UIKit
import XCTest

final class PhotoDetailViewControllerTests: XCTestCase {
    var viewController: PhotoDetailViewController!

    override func setUp() {
        super.setUp()
        viewController = PhotoDetailViewController.instantiate()
    }

    func test_ibOutlets() {
        _ = viewController.view
        XCTAssertNotNil(viewController.collectionView)
    }
}
