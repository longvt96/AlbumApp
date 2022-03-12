//
//  AlbumAssembler.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

protocol AlbumAssembler {
    func resolve(navigationController: UINavigationController) -> AlbumViewController
    func resolve(navigationController: UINavigationController) -> AlbumViewModel
    func resolve(navigationController: UINavigationController) -> AlbumNavigatorType
    func resolve() -> AlbumUseCaseType
}

extension AlbumAssembler {
    func resolve(navigationController: UINavigationController) -> AlbumViewController {
        let vc = AlbumViewController.instantiate()
        let vm: AlbumViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: UINavigationController) -> AlbumViewModel {
        return AlbumViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension AlbumAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> AlbumNavigatorType {
        return AlbumNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> AlbumUseCaseType {
        return AlbumUseCase(userGateway: resolve(),
                            albumGateWay: resolve())
    }
}
