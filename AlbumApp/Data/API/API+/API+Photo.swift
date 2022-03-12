//
//  API+Photo.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import ObjectMapper

extension API {
    func getPhotoList(_ input: GetPhotoListInput) -> Observable<[Photo]> {
        return request(input)
    }
}

// MARK: - GetAlbumList

extension API {
    final class GetPhotoListInput: APIInput {
        init(albumId: Int) {
            let params = [
                "albumId": albumId
            ]
            super.init(urlString: API.Urls.photos,
                       parameters: params,
                       method: .get,
                       requireAccessToken: false)
        }
    }
}

