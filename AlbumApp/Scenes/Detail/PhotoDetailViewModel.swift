//
//  PhotoDetailViewModel.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

struct PhotoDetailViewModel {
    let navigator: PhotoDetailNavigatorType
    let useCase: PhotoDetailUseCaseType
    let albumId: Int
}

// MARK: - ViewModel
extension PhotoDetailViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
    }

    struct Output {
        @Property var photos: [Photo]?
        @Property var isLoading = false
        @Property var error: Error?
    }

    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()

        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()

        errorTracker
            .drive(output.$error)
            .disposed(by: disposeBag)

        activityIndicator
            .asDriver()
            .drive(output.$isLoading)
            .disposed(by: disposeBag)

        input.loadTrigger
            .flatMapLatest {
                useCase.getPhotoList(albumId: albumId)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
            .drive(output.$photos)
            .disposed(by: disposeBag)

        return output
    }
}
