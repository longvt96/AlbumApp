//
//  TestableObserver+.swift
//  AlbumAppTests
//
//  Created by Long Vu on 12/03/2022.
//

import RxTest

extension TestableObserver {
    var lastEventElement: Element? {
        return self.events.last?.value.element
    }
    
    var firstEventElement: Element? {
        return self.events.first?.value.element
    }
}
