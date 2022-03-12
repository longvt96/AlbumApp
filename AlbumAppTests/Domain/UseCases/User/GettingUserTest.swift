//
//  GettingUserTest.swift
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

final class GettingUserTest: XCTestCase, GettingUser {

    var userGateway: UserGatewayType {
        return userGatewayMock
    }

    private var userGatewayMock: UserGatewayMock!
    private var disposeBag: DisposeBag!
    private var getUserListOutput: TestableObserver<[User]>!
    private var scheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        userGatewayMock = UserGatewayMock()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        getUserListOutput = scheduler.createObserver([User].self)
    }

    func test_getAlbumList() {
        // act
        self.getUsers()
            .subscribe(getUserListOutput)
            .disposed(by: disposeBag)

        // assert
        XCTAssert(userGatewayMock.getUsersCalled)
        XCTAssertEqual(getUserListOutput.firstEventElement?.count, 1)
    }
    
    func test_getProductList_fail() {
        // assign
        userGatewayMock.getUsersReturnValue = Observable.error(TestError())

        // act
        self.getUsers()
            .subscribe(getUserListOutput)
            .disposed(by: disposeBag)

        // assert
        XCTAssert(userGatewayMock.getUsersCalled)
        XCTAssertNil(getUserListOutput.firstEventElement)
    }
}
