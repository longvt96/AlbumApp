//
//  AppDelegate.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import RxCocoa
import RxSwift
import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var assembler: Assembler = DefaultAssembler()
    var disposeBag = DisposeBag()

    func applicationDidFinishLaunching(_ application: UIApplication) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        if NSClassFromString("XCTest") != nil { // test
            window.rootViewController = UnitTestViewController()
            window.makeKeyAndVisible()
        } else {
            enableIQKeyboardManager()
            bindViewModel(window: window)
        }
    }

    private func bindViewModel(window: UIWindow) {
        let vm: AppViewModel = assembler.resolve(window: window)
        let input = AppViewModel.Input(loadTrigger: Driver.just(()))
        _ = vm.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - Config

extension AppDelegate {
    // MARK: - IQKeyboardManager
    private func enableIQKeyboardManager() {
        let manager = IQKeyboardManager.shared
        manager.do {
            $0.enable = true
            $0.previousNextDisplayMode = .default
            $0.toolbarDoneBarButtonItemText = "Done"
            $0.shouldResignOnTouchOutside = true
        }
    }
}
