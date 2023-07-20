//
//  MovieCollectionInteractor.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

protocol MovieCollectionInteraction {
    var genre: Genre? { get set }
    var movies: [Movie] { get set }
    var status: Network.Status { get set }
    var page: Int { get set }
    func fetchMovies()
}

protocol MovieCollectionInteractorOutput: AnyObject {
    func movieFetched()
    func fetchFailure(error: String)
}

class MovieCollectionInteractor: MovieCollectionInteraction {
    private let service: MovieRepository
    weak var output: MovieCollectionPresenter?
    var genre: Genre?
    var movies = [Movie]()
    var status: Network.Status = .notLoad

    var page = 1

    init(service: MovieRepository) {
        self.service = service
    }

    func fetchMovies() {
        let genreID = genre?.id ?? 0
        status = .loading
        service.getMovieList(genreID: genreID, page: page, responseType: MovieList.self) { [weak self] result in
            switch result {
            case .success(let data):
                if data.success == false, let statusMsg = data.statusMessage {
                    self?.status = .failed
                    self?.output?.fetchFailure(error: statusMsg)
                } else {
                    self?.status = .success
                    self?.movies.append(contentsOf: data.results ?? [])
                    self?.output?.movieFetched()
                }
            case .failure(let error):
                self?.status = .failed
                self?.output?.fetchFailure(error: error.localizedDescription)
            }
        }
    }

}
