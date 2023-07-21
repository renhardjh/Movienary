//
//  MovieDetail.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import Foundation

struct MovieDetail: Decodable, BaseResponse {
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?

    let id, voteCount: Int?
    let video: Bool?
    let backdropPath: String?
    let genres: [Genre]?
    let originalTitle, overview: String?
    let popularity, voteAverage: Double?
    let posterPath, releaseDate, title: String?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
        case backdropPath = "backdrop_path"
        case id, genres
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
