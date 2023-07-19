//
//  MovieService.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

protocol MovieRepository {
    func getGenreMovieList<T: Decodable>(responseType: T.Type, completion: @escaping(Result<T, Error>) -> Void)
}

class MovieService: MovieRepository {
    func getGenreMovieList<T: Decodable>(responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let endpoint = NetworkEndpointMovie.getGenreList
        NetworkService.shared.request(.get, endpoint, responseType: responseType.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
