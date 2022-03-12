//
//  Utils.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022. All rights reserved.
//

import Foundation

func after(interval: TimeInterval, completion: (() -> Void)?) {
    DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
        completion?()
    }
}
