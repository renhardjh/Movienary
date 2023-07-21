//
//  MovieVideoList.swift
//  Movienary
//
//  Created by RenhardJH on 21/07/23.
//

import Foundation

struct MovieVideoList: Decodable, BaseResponse {
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?

    let id: Int?
    let results: [MovieVideo]?
}

struct MovieVideo: Decodable {
    let name, key: String?
    let size: Int?
    let type: String?
    let official: Bool?
}
