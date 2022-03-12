//
//  API+Album.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import ObjectMapper

extension API {
    func getAlbumList(_ input: GetAlbumListInput) -> Observable<[Album]> {
        return request(input)
    }
}

// MARK: - GetAlbumList

extension API {
    final class GetAlbumListInput: APIInput {
        init(userId: Int?) {
            var params: [String: Any] = [:]
            if let userId = userId {
                params["userId"] = userId
            }
            super.init(urlString: API.Urls.albums,
                       parameters: params,
                       method: .get,
                       requireAccessToken: false)
        }
    }
}
