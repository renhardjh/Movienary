//
//  GenreCollectionPresenter.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

protocol GenreCollectionPresentation: ItemPresentation {
    var pageTitle: String { get }
    var featureTitle: String { get }
    var genreCount: Int { get }
    var sectionCount: Int { get }
    var skeletonCount: Int { get }
    var coloumnCount: Int { get }
    var cellHeight: CGFloat { get }
    func selectGenre(_ genre: Genre)
    func loadGenres()
}

class GenreCollectionPresenter: GenreCollectionPresentation {
    private weak var view: GenreCollectionViewInterface?
    private let interactor: GenreCollectionInteractor
    private let router: GenreCollectionRouter

    let pageTitle = "Movienary"
    let sectionCount = 1
    let skeletonCount = 24
    let coloumnCount = 3
    let cellHeight: CGFloat = 80

    var genreCount: Int {
        return interactor.genres.count
    }

    var featureTitle: String {
        return "Select Genre"
    }

    init(view: GenreCollectionViewInterface, router: GenreCollectionRouter, interactor: GenreCollectionInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    func loadGenres() {
        view?.displayLoading()
        interactor.fetchGenres()
    }

    func selectGenre(_ genre: Genre) {
        router.presentMovieCollectionView(with: genre)
    }

    func item<T>(at: Int) -> T? {
        return interactor.genres.item(at: at) as? T
    }
}

extension GenreCollectionPresenter: GenreCollectionInteractorOutput {
    func genreFetched() {
        view?.hideLoading()
        if interactor.genres.isEmpty {
            view?.displayAlert(type: .info, message: UniversalMessage.emptyGenre.description)
        } else {
            view?.displayGenres()
        }
    }

    func fetchFailure(error: String) {
        view?.hideLoading()
        view?.displayAlert(type: .error, message: error)
    }
}
