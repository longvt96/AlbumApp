//
//  API+UserTest.swift
//  AlbumAppTests
//
//  Created by Long Vu on 12/03/2022.
//

@testable import AlbumApp
import XCTest
import RxTest
import RxSwift
import OHHTTPStubs

final class APIUserTests: XCTestCase {
    let host = API.Host.domain
    let path = API.Paths.users
    private var getUserListOutput: TestableObserver<[User]>!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        getUserListOutput = scheduler.createObserver([User].self)
        disposeBag = DisposeBag()
    }

    func test_APIRepo_Success() {
        // act
        stub(condition: isHost(host) && isPath(path)) { _ in
            let stubPath = OHPathForFile("users.json", type(of: self))
            return fixture(filePath: stubPath!, // swiftlint:disable:this force_unwrapping
                           headers: ["Content-Type": "application/json"])
        }
        let input = API.GetUserListInput()
        API.shared.getUserList(input)
            .subscribe(getUserListOutput)
            .disposed(by: disposeBag)
        
        // assert
        wait {
            XCTAssertNotNil(self.getUserListOutput.firstEventElement)
            XCTAssertEqual(self.getUserListOutput.firstEventElement?.count, 10)
            XCTAssertEqual(self.getUserListOutput.firstEventElement?.first?.id, 1)
            XCTAssertEqual(self.getUserListOutput.firstEventElement?.first?.name, "Leanne Graham")
        }
    }
}
