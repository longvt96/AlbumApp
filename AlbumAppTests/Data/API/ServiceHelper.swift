//
//  ServiceHelper.swift
//  AlbumAppTests
//
//  Created by Long Vu on 12/03/2022.
//

import XCTest

extension XCTestCase {
    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        // swiftlint:disable:next force_unwrapping
        return try! Data(contentsOf: url!) // swiftlint:disable:this force_try
    }
}
