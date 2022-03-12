//
//  AppNavigator.swift
//  Album
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

import UIKit

protocol AppNavigatorType {
    func toAlbum()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow

    func toAlbum() {
        let navigator = UINavigationController()
        let vc: AlbumViewController = assembler.resolve(navigationController: navigator)
        navigator.viewControllers = [vc]
        window.rootViewController = navigator
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
