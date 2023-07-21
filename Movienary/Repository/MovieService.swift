//
//  MovieService.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

protocol MovieRepository {
    func getGenreMovieList<T: Decodable>(responseType: T.Type, completion: @escaping(Result<T, Error>) -> Void)

    func getMovieList<T: Decodable>(genreID: Int, page: Int, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable

    func getMovieDetail<T: Decodable>(movieID: Int, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable

    func getMovieReview<T: Decodable>(movieID: Int, page: Int, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable

    func getMovieVideo<T: Decodable>(movieID: Int, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable
}

class MovieService: MovieRepository {
    func getGenreMovieList<T: Decodable>(responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let endpoint = NetworkEndpointMovie.getGenreList
        NetworkService.shared.request(.get, endpoint, responseType: responseType.self) { result in
            completion(result)
        }
    }

    func getMovieList<T: Decodable>(genreID: Int, page: Int, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let endpoint = NetworkEndpointMovie.getMovieList(genreID: genreID, page: page)
        NetworkService.shared.request(.get, endpoint, responseType: responseType.self) { result in
            completion(result)
        }
    }

    func getMovieDetail<T: Decodable>(movieID: Int, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let endpoint = NetworkEndpointMovie.getMovieDetail(movieID: movieID)
        NetworkService.shared.request(.get, endpoint, responseType: responseType.self) { result in
            completion(result)
        }
    }

    func getMovieReview<T: Decodable>(movieID: Int, page: Int, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let endpoint = NetworkEndpointMovie.getMovieReview(movieID: movieID, page: page)
        NetworkService.shared.request(.get, endpoint, responseType: responseType.self) { result in
            completion(result)
        }
    }

    func getMovieVideo<T: Decodable>(movieID: Int, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let endpoint = NetworkEndpointMovie.getMovieVideo(movieID: movieID)
        NetworkService.shared.request(.get, endpoint, responseType: responseType.self) { result in
            completion(result)
        }
    }
}
