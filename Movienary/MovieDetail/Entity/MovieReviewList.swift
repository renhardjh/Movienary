//
//  ReviewModel.swift
//  Movienary
//
//  Created by RenhardJH on 21/07/23.
//

import Foundation

struct MovieReviewList: Decodable, BaseResponse {
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?

    let id: Int?
    let results: [MovieReview]?
    let totalPages, page, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieReview: Codable {
    let author: String?
    let authorDetails: ReviewAuthorDetail?
    let content, createdAt, id, updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

struct ReviewAuthorDetail: Codable {
    let name, username: String?
    let avatarPath: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
