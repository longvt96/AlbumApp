//
//  AppViewModel.swift
//  Album
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

import MGArchitecture
import RxCocoa
import RxSwift

struct AppViewModel {
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
}

// MARK: - ViewModel
extension AppViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {

    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        input.loadTrigger
            .drive(onNext: navigator.toAlbum)
            .disposed(by: disposeBag)

        return Output()
    }
}
