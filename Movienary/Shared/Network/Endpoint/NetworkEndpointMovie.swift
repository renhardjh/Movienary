//
//  NetworkEndpointMovie.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

enum NetworkEndpointMovie: NetworkEndpoint {
    case getGenreList
    case getMovieList(genreID: Int, page: Int)
    case getMovieDetail(movieID: Int)
    case getMovieReview(movieID: Int, page: Int)
    case getMovieVideo(movieID: Int)

    var value: String {
        switch self {
        case .getGenreList:
            return "3/genre/movie/list"
            
        case .getMovieList(let genreID, let page):
            return "3/discover/movie?page=\(page)&with_genres=\(genreID)"

        case .getMovieDetail(let movieID):
            return "/3/movie/\(movieID)"

        case .getMovieReview(let movieID, let page):
            return "3/movie/\(movieID)/reviews?page=\(page)"

        case .getMovieVideo(let movieID):
            return "3/movie/\(movieID)/videos"
        }
    }
}
