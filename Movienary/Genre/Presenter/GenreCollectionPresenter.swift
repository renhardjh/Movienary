//
//  GenreCollectionPresenter.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

protocol GenreCollectionPresentation: ItemPresentation {
    var genreCount: Int { get }
    var sectionCount: Int { get }
    var skeletonCount: Int { get }
    var coloumnCount: Int { get }
    var cellHeight: CGFloat { get }
    func loadGenres()
}

class GenreCollectionPresenter: GenreCollectionPresentation {
    private weak var view: GenreCollectionViewInterface?
    private let interactor: GenreCollectionInteractor

    let sectionCount = 1
    let skeletonCount = 24
    let coloumnCount = 3
    let cellHeight: CGFloat = 100

    var genreCount: Int {
        return interactor.genres.count
    }

    init(view: GenreCollectionViewInterface, interactor: GenreCollectionInteractor) {
        self.view = view
        self.interactor = interactor
    }

    func loadGenres() {
        interactor.fetchGenres()
    }

    func item<T>(at: Int) -> T? {
        return interactor.genres.item(at: at) as? T
    }
}

extension GenreCollectionPresenter: GenreCollectionInteractorOutput {
    func genreFetched() {
        view?.displayGenres()
    }

    func fetchFailure(error: String) {
        view?.displayError(message: error)
    }
}
