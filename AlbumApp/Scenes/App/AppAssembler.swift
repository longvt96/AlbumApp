//
//  AppAssembler.swift
//  Album
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

import UIKit

protocol AppAssembler {
    func resolve(window: UIWindow) -> AppViewModel
    func resolve(window: UIWindow) -> AppNavigatorType
    func resolve() -> AppUseCaseType
}

extension AppAssembler {
    func resolve(window: UIWindow) -> AppViewModel {
        return AppViewModel(navigator: resolve(window: window), useCase: resolve())
    }
}

extension AppAssembler where Self: DefaultAssembler {
    func resolve(window: UIWindow) -> AppNavigatorType {
        return AppNavigator(assembler: self, window: window)
    }
    
    func resolve() -> AppUseCaseType {
        return AppUseCase()
    }
}
