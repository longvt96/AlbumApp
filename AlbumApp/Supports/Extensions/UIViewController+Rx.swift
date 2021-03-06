//
//  UIViewController+Rx.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022. All rights reserved.
//

import MBProgressHUD
import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIViewController {
    var error: Binder<Error> {
        return Binder(base) { viewController, error in
            viewController.showError(message: error.localizedDescription)
        }
    }
    
    var isLoading: Binder<Bool> {
        return Binder(base) { viewController, isLoading in
            if isLoading {
                let hud = MBProgressHUD.showAdded(to: viewController.view, animated: true)
                hud.offset.y = -30
            } else {
                MBProgressHUD.hide(for: viewController.view, animated: true)
            }
        }
    }
}
