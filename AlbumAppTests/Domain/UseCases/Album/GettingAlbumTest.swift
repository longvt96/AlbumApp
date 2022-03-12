//
//  GettingAlbumTest.swift
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

final class GettingAlbumTest: XCTestCase, GettingAlbum {

    var albumGateWay: AlbumGatewayType {
        return albumGateWayMock
    }

    private var albumGateWayMock: AlbumGatewayMock!
    private var disposeBag: DisposeBag!
    private var getAlbumListOutput: TestableObserver<[Album]>!
    private var scheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        albumGateWayMock = AlbumGatewayMock()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        getAlbumListOutput = scheduler.createObserver([Album].self)
    }

    func test_getAlbumList() {
        // act
        self.getAlbum(userID: nil)
            .subscribe(getAlbumListOutput)
            .disposed(by: disposeBag)

        // assert
        XCTAssert(albumGateWayMock.getAlbumCalled)
        XCTAssertEqual(getAlbumListOutput.firstEventElement?.count, 1)
    }
    
    func test_getAlbumList_fail() {
        // assign
        albumGateWayMock.getAlbumReturnValue = Observable.error(TestError())

        // act
        self.getAlbum(userID: nil)
            .subscribe(getAlbumListOutput)
            .disposed(by: disposeBag)

        // assert
        XCTAssert(albumGateWayMock.getAlbumCalled)
        XCTAssertNil(getAlbumListOutput.firstEventElement)
    }
}
