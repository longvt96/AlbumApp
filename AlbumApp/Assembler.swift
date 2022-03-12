//
//  Assembler.swift
//  AlbnumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022. All rights reserved.
//

protocol Assembler: AnyObject,
                    GatewaysAssembler,
                    AlbumAssembler,
                    PhotoDetailAssembler,
                    AppAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}
