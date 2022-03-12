//
//  AlbumViewModel.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

struct AlbumViewModel {
    let navigator: AlbumNavigatorType
    let useCase: AlbumUseCaseType
}

// MARK: - ViewModel
extension AlbumViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
        let searchKeywordTrigger: Driver<String?>
        let selectedTrigger: Driver<IndexPath>
    }

    struct Output {
        @Property var albums: [Album]?
        @Property var users: [User] = []
        @Property var error: Error?
        @Property var isLoading = false
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

        let allAlbum = input.loadTrigger
            .flatMapLatest {
                useCase.getAlbum(userID: nil)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }

        allAlbum
            .drive(output.$albums)
            .disposed(by: disposeBag)

        input.loadTrigger
            .flatMapLatest {
                useCase.getUsers()
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .drive(output.$users)
            .disposed(by: disposeBag)

        input.searchKeywordTrigger
            .filter { $0?.isEmpty == true || $0 == nil }
            .withLatestFrom(allAlbum)
            .drive(output.$albums)
            .disposed(by: disposeBag)

        input.searchKeywordTrigger
            .filter { $0?.isEmpty == false }
            .compactMap { $0 }
            .withLatestFrom(allAlbum) { ($0, $1) }
            .map { keyword, albums -> [Album] in
                useCase.searchUser(keyword: keyword, users: output.users, albums: albums)
            }
            .drive(output.$albums)
            .disposed(by: disposeBag)

        input.selectedTrigger
            .drive(onNext: {
                guard let albumId = output.albums?[$0.row].id else {
                    return
                }
                navigator.toPhotoDetail(albumId: albumId)
            })
            .disposed(by: disposeBag)

        return output
    }
}
