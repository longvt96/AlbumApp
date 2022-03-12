//
//  PhotoDetailViewModelTests.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

@testable import AlbumApp
import RxCocoa
import RxSwift
import XCTest

final class PhotoDetailViewModelTests: XCTestCase {
    private var viewModel: PhotoDetailViewModel!
    private var navigator: PhotoDetailNavigatorMock!
    private var useCase: PhotoDetailUseCaseMock!
    private var input: PhotoDetailViewModel.Input!
    private var output: PhotoDetailViewModel.Output!
    private var disposeBag: DisposeBag!

    // Triggers
    private let loadTrigger = PublishSubject<Void>()

    override func setUp() {
        super.setUp()
        navigator = PhotoDetailNavigatorMock()
        useCase = PhotoDetailUseCaseMock()
        viewModel = PhotoDetailViewModel(navigator: navigator,
                                         useCase: useCase,
                                         albumId: 1)
        
        input = PhotoDetailViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete()
        )

        disposeBag = DisposeBag()
        output = viewModel.transform(input, disposeBag: disposeBag)
    }
    
    func test_loadTriggerTrigger_loadData() {
        // act
        loadTrigger.onNext(())

        // assert
        XCTAssert(useCase.getPhotoListCalled)
        XCTAssertEqual(output.photos?.count, 1)
    }

    func test_loadTriggerInvoked_getData_failedShowError() {
        // arrange
        useCase.getPhotoListReturnValue = Observable.error(TestError())

        // act
        loadTrigger.onNext(())

        // assert
        XCTAssert(useCase.getPhotoListCalled)
        XCTAssert(output.error is TestError)
    }

    func test_loadTriggerInvoked_getData_showLoading() {
        // arrange
        useCase.getPhotoListReturnValue = Observable.never()

        // act
        loadTrigger.onNext(())

        // assert
        XCTAssert(useCase.getPhotoListCalled)
        XCTAssertTrue(output.isLoading)
    }
}
