//
//  API+PhotoTest.swift
//  AlbumAppTests
//
//  Created by Long Vu on 12/03/2022.
//

@testable import AlbumApp
import XCTest
import RxTest
import RxSwift
import OHHTTPStubs

final class APIPhotoTests: XCTestCase {
    let host = API.Host.domain
    let path = API.Paths.photos
    private var getPhotoListOutput: TestableObserver<[Photo]>!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        getPhotoListOutput = scheduler.createObserver([Photo].self)
        disposeBag = DisposeBag()
    }

    func test_APIRepo_Success() {
        // act
        stub(condition: isHost(host) && isPath(path)) { _ in
            let stubPath = OHPathForFile("photos.json", type(of: self))
            return fixture(filePath: stubPath!, // swiftlint:disable:this force_unwrapping
                           headers: ["Content-Type": "application/json"])
        }
        let input = API.GetPhotoListInput(albumId: 1)
        API.shared.getPhotoList(input)
            .subscribe(getPhotoListOutput)
            .disposed(by: disposeBag)
        
        // assert
        wait {
            XCTAssertNotNil(self.getPhotoListOutput.firstEventElement)
            XCTAssertEqual(self.getPhotoListOutput.firstEventElement?.count, 50)
            XCTAssertEqual(self.getPhotoListOutput.firstEventElement?.first?.id, 1)
            XCTAssertEqual(self.getPhotoListOutput.firstEventElement?.first?.title,
                           "accusamus beatae ad facilis cum similique qui sunt")
        }
    }
}
