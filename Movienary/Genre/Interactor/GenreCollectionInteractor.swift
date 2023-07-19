//
//  GenreCollectionInteractor.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

protocol GenreCollectionInteraction {
    var genres: [Genre] { get set }
    func fetchGenres()
}

protocol GenreCollectionInteractorOutput: AnyObject {
    func genreFetched()
    func fetchFailure(error: String)
}

class GenreCollectionInteractor: GenreCollectionInteraction {
    private let service: MovieRepository
    weak var output: GenreCollectionPresenter?
    var genres = [Genre]()

    init(service: MovieRepository) {
        self.service = service
    }

    func fetchGenres() {
        service.getGenreMovieList(responseType: GenreList.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.genres = data.genres
                self?.output?.genreFetched()
            case .failure(let error):
                self?.output?.fetchFailure(error: error.localizedDescription)
            }
        }
    }

}
