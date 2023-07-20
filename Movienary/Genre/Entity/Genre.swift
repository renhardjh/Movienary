//
//  Genre.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

struct GenreList: Decodable, BaseResponse {
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
        case genres
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
