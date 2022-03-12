//
//  GatewaysAssembler.swift
//  Album
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

protocol GatewaysAssembler {
    func resolve() -> AlbumGatewayType
    func resolve() -> UserGatewayType
    func resolve() -> PhotoGatewayType
}

extension GatewaysAssembler where Self: DefaultAssembler {
    func resolve() -> AlbumGatewayType {
        AlbumGateway()
    }

    func resolve() -> UserGatewayType {
        UserGateway()
    }

    func resolve() -> PhotoGatewayType {
        PhotoGateway()
    }
}
