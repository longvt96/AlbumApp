//
//  PhotoDetailAssembler.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

import Reusable
import UIKit

protocol PhotoDetailAssembler {
    func resolve(navigationController: UINavigationController,
                 albumId: Int) -> PhotoDetailViewController
    func resolve(navigationController: UINavigationController,
                 albumId: Int) -> PhotoDetailViewModel
    func resolve(navigationController: UINavigationController) -> PhotoDetailNavigatorType
    func resolve() -> PhotoDetailUseCaseType
}

extension PhotoDetailAssembler {
    func resolve(navigationController: UINavigationController,
                 albumId: Int) -> PhotoDetailViewController {
        let vc = PhotoDetailViewController.instantiate()
        let vm: PhotoDetailViewModel = resolve(navigationController: navigationController,
                                               albumId: albumId)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: UINavigationController,
                 albumId: Int) -> PhotoDetailViewModel {
        return PhotoDetailViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            albumId: albumId
        )
    }
}

extension PhotoDetailAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> PhotoDetailNavigatorType {
        return PhotoDetailNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> PhotoDetailUseCaseType {
        return PhotoDetailUseCase(photoGateway: resolve())
    }
}
