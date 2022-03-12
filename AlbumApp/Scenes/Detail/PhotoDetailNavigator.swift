//
//  PhotoDetailNavigator.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

import UIKit

protocol PhotoDetailNavigatorType {

}

struct PhotoDetailNavigator: PhotoDetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}