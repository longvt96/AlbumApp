//
//  API+User.swift
//  AlbumApp
//
//  Created by Long Vu on 11/03/2022.
//

import ObjectMapper

extension API {
    func getUserList(_ input: GetUserListInput) -> Observable<[User]> {
        return request(input)
    }
}

// MARK: - GetAlbumList

extension API {
    final class GetUserListInput: APIInput {
        init() {
            super.init(urlString: API.Urls.users,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: false)
        }
    }
}
