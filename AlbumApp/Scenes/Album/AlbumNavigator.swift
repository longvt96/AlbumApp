//
//  AlbumNavigator.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

import UIKit

protocol AlbumNavigatorType {
    func toPhotoDetail(albumId: Int)
}

struct AlbumNavigator: AlbumNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController

    func toPhotoDetail(albumId: Int) {
        let vc: PhotoDetailViewController = assembler.resolve(navigationController: navigationController,
                                                              albumId: albumId)
        navigationController.pushViewController(vc, animated: true)
    }
}
