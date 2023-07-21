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
    var totalPages: Int { get set }
    var currentPage: Int { get set }
    var page: Int { get set }
    func fetchMovies()
}

protocol MovieCollectionInteractorOutput: AnyObject {
    func movieFetched()
    func fetchFailure(error: String)
}

class MovieCollectionInteractor: MovieCollectionInteraction {
    private let service: MovieRepository
    weak var output: MovieCollectionInteractorOutput?
    var genre: Genre?
    var movies = [Movie]()
    var totalPages = 0

    var currentPage = 0
    var page = 1

    init(service: MovieRepository) {
        self.service = service
    }

    func fetchMovies() {
        let genreID = genre?.id ?? 0
        service.getMovieList(genreID: genreID, page: page, responseType: MovieList.self) { [weak self] result in
            switch result {
            case .success(let data):
                if data.success == false, let statusMsg = data.statusMessage {
                    self?.output?.fetchFailure(error: statusMsg)
                } else {
                    self?.movies.append(contentsOf: data.results ?? [])
                    self?.totalPages = data.totalPages
                    self?.currentPage = data.page
                    self?.output?.movieFetched()
                }
            case .failure(let error):
                self?.output?.fetchFailure(error: error.localizedDescription)
            }
        }
    }

}
