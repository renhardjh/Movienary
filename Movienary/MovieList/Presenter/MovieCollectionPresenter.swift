//
//  MovieCollectionPresenter.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

protocol MovieCollectionPresentation: ItemPresentation {
    var pageTitle: String { get }
    var featureTitle: String { get }
    var movieCount: Int { get }
    var sectionCount: Int { get }
    var genre: Genre? { get }
    var skeletonCount: Int { get }
    var coloumnCount: Int { get }
    var cellHeight: CGFloat { get }
    var loadingMoreHeight: CGFloat { get }
    func selectMovie(_ movie: Movie)
    func loadMovies()
    func endLessScroll(_ indexPath: IndexPath)
}

class MovieCollectionPresenter: MovieCollectionPresentation {
    private weak var view: MovieCollectionViewInterface?
    private let interactor: MovieCollectionInteractor
    private let router: MovieCollectionRouter

    let pageTitle = "Movie List"
    let sectionCount = 1
    let skeletonCount = 12
    let coloumnCount = 3
    let cellHeight: CGFloat = 260
    let loadingMoreHeight: CGFloat = 50.0

    var featureTitle: String {
        return "Discover \(genre?.name ?? "") Movies"
    }

    var genre: Genre? {
        return interactor.genre
    }

    var movieCount: Int {
        return interactor.movies.count
    }

    private var isLastPage: Bool {
        return interactor.currentPage == interactor.totalPages
    }

    private var canLoadMore: Bool {
        return interactor.page == interactor.currentPage
    }

    init(view: MovieCollectionViewInterface, router: MovieCollectionRouter, interactor: MovieCollectionInteractor) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func selectMovie(_ movie: Movie) {
        router.presentMovieDetailnView(with: movie)
    }

    func item<T>(at: Int) -> T? {
        return interactor.movies.item(at: at) as? T
    }

    func loadMovies() {
        view?.displayLoading()
        interactor.fetchMovies()
    }

    func endLessScroll(_ indexPath: IndexPath) {
        if indexPath.item == movieCount - coloumnCount,
           !isLastPage,
           canLoadMore {
            interactor.page += 1
            interactor.fetchMovies()
        }
    }
}

extension MovieCollectionPresenter: MovieCollectionInteractorOutput {
    func movieFetched() {
        view?.hideLoading()
        if interactor.movies.isEmpty {
            view?.displayAlert(type: .info, message: UniversalMessage.emptyMovie.description)
        } else {
            view?.displayMovies()
        }
    }

    func fetchFailure(error: String) {
        view?.hideLoading()
        view?.displayAlert(type: .error, message: error)
    }
}
