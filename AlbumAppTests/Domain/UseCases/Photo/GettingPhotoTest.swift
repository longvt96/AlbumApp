//
//  GettingPhotoTest.swift
//  AlbumAppTests
//
//  Created by Long Vu on 12/03/2022.
//

@testable import AlbumApp
import XCTest
import RxTest
import RxSwift
import RxCocoa
import MGArchitecture

final class GettingPhotoTest: XCTestCase, GettingPhoto {

    var photoGateway: PhotoGatewayType {
        return photoGatewayMock
    }

    private var photoGatewayMock: PhotoGatewayMock!
    private var disposeBag: DisposeBag!
    private var getPhotoListOutput: TestableObserver<[Photo]>!
    private var scheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        photoGatewayMock = PhotoGatewayMock()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        getPhotoListOutput = scheduler.createObserver([Photo].self)
    }

    func test_getPhotoList() {
        // act
        self.getPhotoList(albumId: 1)
            .subscribe(getPhotoListOutput)
            .disposed(by: disposeBag)

        // assert
        XCTAssert(photoGatewayMock.getPhotosCalled)
        XCTAssertEqual(getPhotoListOutput.firstEventElement?.count, 1)
    }
    
    func test_getPhotoList_fail() {
        // assign
        photoGatewayMock.getPhotosReturnValue = Observable.error(TestError())

        // act
        self.getPhotoList(albumId: 1)
            .subscribe(getPhotoListOutput)
            .disposed(by: disposeBag)

        // assert
        XCTAssert(photoGatewayMock.getPhotosCalled)
        XCTAssertNil(getPhotoListOutput.firstEventElement)
    }
}
