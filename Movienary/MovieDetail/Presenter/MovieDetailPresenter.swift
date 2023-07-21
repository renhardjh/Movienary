//
//  MovieDetailPresenter.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import Foundation

protocol MovieDetailPresentation: ItemPresentation {
    var movieDetail: MovieDetail? { get }
    var movieTrailer: MovieVideo? { get }
    var sectionCount: Int { get }
    var reviewCount: Int { get }
    var detailCount: Int { get }
    var headerReviewTitle: String { get }
    var skeletonCount: Int { get }
    var reviewCellHeight: CGFloat { get }
    func loadMovieDetail()
    func loadMovieVideo()
    func endLessScroll(_ indexPath: IndexPath)
}

class MovieDetailPresenter: MovieDetailPresentation {
    private weak var view: MovieDetailViewInterface?
    private let interactor: MovieDetailInteractor
    private let router: MovieDetailRouter

    let sectionCount = 2
    let detailCount = 1
    let reviewCellHeight: CGFloat = 120
    var skeletonCount = 3
    let headerReviewTitle = "Reviews"

    var movieDetail: MovieDetail? {
        return interactor.movieDetail
    }

    var movieTrailer: MovieVideo? {
        return interactor.videos.first(where: { $0.type == "Trailer" })
    }

    var reviewCount: Int {
        return interactor.reviews.count
    }

    private var isLastPage: Bool {
        return interactor.currentPage == interactor.totalPages
    }

    private var canLoadMore: Bool {
        return interactor.page == interactor.currentPage
    }

    init(view: MovieDetailViewInterface, router: MovieDetailRouter, interactor: MovieDetailInteractor) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func item<T>(at: Int) -> T? {
        return interactor.reviews.item(at: at) as? T
    }

    func selectMovie(_ movie: Movie) {
        router.presentMovieDetailnView(with: movie)
    }

    func loadMovieDetail() {
        view?.displayLoading()
        interactor.fetchMovies()
        interactor.fetchMovieReviews()
    }

    func loadMovieVideo() {
        interactor.fetchMovieVideo()
    }

    func endLessScroll(_ indexPath: IndexPath) {
        if indexPath.item == reviewCount - 2,
           !isLastPage,
           canLoadMore {
            interactor.page += 1
            interactor.fetchMovieReviews()
        }
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutput {
    func movieDetailFetched() {
        view?.hideLoading()
        view?.displayMovieDetail()
    }

    func movieReviewFetched() {
        view?.hideLoading()
        view?.displayMovieDetail()
    }

    func movieVideoFetched() {
        view?.displayMovieDetail()
    }

    func fetchFailure(error: String) {
        view?.hideLoading()
        view?.displayAlert(type: .error, message: error)
    }
}
