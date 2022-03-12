//
//  API+AlbumTest.swift
//  AlbumAppTests
//
//  Created by Long Vu on 12/03/2022.
//

@testable import AlbumApp
import XCTest
import RxTest
import RxSwift
import OHHTTPStubs

final class APIAlbumTests: XCTestCase {
    let host = API.Host.domain
    let path = API.Paths.albums
    private var getAlbumListOutput: TestableObserver<[Album]>!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        getAlbumListOutput = scheduler.createObserver([Album].self)
        disposeBag = DisposeBag()
    }

    func test_APIRepo_Success() {
        // act
        stub(condition: isHost(host) && isPath(path)) { _ in
            let stubPath = OHPathForFile("albums.json", type(of: self))
            return fixture(filePath: stubPath!, // swiftlint:disable:this force_unwrapping
                           headers: ["Content-Type": "application/json"])
        }
        let input = API.GetAlbumListInput(userId: nil)
        API.shared.getAlbumList(input)
            .compactMap { $0 }
            .subscribe(getAlbumListOutput)
            .disposed(by: disposeBag)
        
        // assert
        wait {
            XCTAssertNotNil(self.getAlbumListOutput.firstEventElement)
            XCTAssertEqual(self.getAlbumListOutput.firstEventElement?.count, 100)
            XCTAssertEqual(self.getAlbumListOutput.firstEventElement?.first?.id, 1)
            XCTAssertEqual(self.getAlbumListOutput.firstEventElement?.first?.title, "quidem molestiae enim")
        }
    }
}
