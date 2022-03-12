//
//  PhotoDetailUseCase.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

import RxSwift

protocol PhotoDetailUseCaseType {
    func getPhotoList(albumId: Int) -> Observable<[Photo]>
}

struct PhotoDetailUseCase: PhotoDetailUseCaseType, GettingPhoto {
    var photoGateway: PhotoGatewayType

}
