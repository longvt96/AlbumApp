//
//  AlbumViewModelTests.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

@testable import AlbumApp
import RxCocoa
import RxSwift
import XCTest

final class AlbumViewModelTests: XCTestCase {
    private var viewModel: AlbumViewModel!
    private var navigator: AlbumNavigatorMock!
    private var useCase: AlbumUseCaseMock!
    private var input: AlbumViewModel.Input!
    private var output: AlbumViewModel.Output!
    private var disposeBag: DisposeBag!

    // Triggers
    private let loadTrigger = PublishSubject<Void>()
    private let searchKeywordTrigger = PublishSubject<String?>()
    private let selectedTrigger = PublishSubject<IndexPath>()

    override func setUp() {
        super.setUp()
        navigator = AlbumNavigatorMock()
        useCase = AlbumUseCaseMock()
        viewModel = AlbumViewModel(navigator: navigator, useCase: useCase)
        
        input = AlbumViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            searchKeywordTrigger: searchKeywordTrigger.asDriverOnErrorJustComplete(),
            selectedTrigger: selectedTrigger.asDriverOnErrorJustComplete()
        )

        disposeBag = DisposeBag()
        output = viewModel.transform(input, disposeBag: disposeBag)
    }
    
    func test_loadTriggerTrigger_loadData() {
        // act
        loadTrigger.onNext(())

        // assert
        XCTAssert(useCase.getUsersCalled)
        XCTAssert(useCase.getAlbumCalled)
        XCTAssertEqual(output.albums?.count, 2)
        XCTAssertEqual(output.users.count, 1)
    }

    func test_loadTriggerInvoked_getData_failedShowError() {
        // arrange
        useCase.getUsersReturnValue = Observable.error(TestError())
        useCase.getAlbumReturnValue = Observable.error(TestError())

        // act
        loadTrigger.onNext(())

        // assert
        XCTAssert(useCase.getAlbumCalled)
        XCTAssert(useCase.getUsersCalled)
        XCTAssert(output.error is TestError)
    }

    func test_loadTriggerInvoked_getData_showLoading() {
        // arrange
        useCase.getAlbumReturnValue = Observable.never()

        // act
        loadTrigger.onNext(())

        // assert
        XCTAssert(useCase.getAlbumCalled)
        XCTAssert(useCase.getUsersCalled)
        XCTAssertTrue(output.isLoading)
    }

    func test_searchKeywordTriggerTrigger_() {
        // act
        loadTrigger.onNext(())
        searchKeywordTrigger.onNext("1")

        // assert
        XCTAssert(useCase.getUsersCalled)
        XCTAssert(useCase.getAlbumCalled)
        XCTAssertEqual(output.albums?.count, 1)
    }

    func test_selectedTriggerTrigger_toDetail() {
        // act
        loadTrigger.onNext(())
        selectedTrigger.onNext(IndexPath(row: 0, section: 0))

        // assert
        XCTAssert(useCase.getUsersCalled)
        XCTAssert(useCase.getAlbumCalled)
        XCTAssert(navigator.toPhotoDetailCalled)
    }
}
