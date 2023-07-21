//
//  MovieDetailInteractor.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import Foundation

protocol MovieDetailInteraction {
    var movie: Movie? { get set }
    var movieDetail: MovieDetail? { get set }
    var reviews: [MovieReview] { get set }
    var videos: [MovieVideo] { get set }
    var currentPage: Int { get set }
    var totalPages: Int { get set }
    func fetchMovies()
    func fetchMovieReviews()
    func fetchMovieVideo()
}

protocol MovieDetailInteractorOutput: AnyObject {
    func movieDetailFetched()
    func movieReviewFetched()
    func movieVideoFetched()
    func fetchFailure(error: String)
}

class MovieDetailInteractor: MovieDetailInteraction {
    private let service: MovieRepository
    weak var output: MovieDetailInteractorOutput?
    var movie: Movie?
    var movieDetail: MovieDetail?
    var reviews = [MovieReview]()
    var videos = [MovieVideo]()
    var reviewExpanded = [Bool]()

    var currentPage = 0
    var page = 1
    var totalPages = 0

    private var movieID: Int {
        movie?.id ?? 0
    }

    init(service: MovieRepository) {
        self.service = service
    }

    func fetchMovies() {
        service.getMovieDetail(movieID: movieID, responseType: MovieDetail.self) { [weak self] result in
            switch result {
            case .success(let data):
                if data.success == false, let statusMsg = data.statusMessage {
                    self?.output?.fetchFailure(error: statusMsg)
                } else {
                    self?.movieDetail = data
                    self?.output?.movieDetailFetched()
                }
            case .failure(let error):
                self?.output?.fetchFailure(error: error.localizedDescription)
            }
        }
    }

    func fetchMovieReviews() {
        service.getMovieReview(movieID: movieID, page: page, responseType: MovieReviewList.self) { [weak self] result in
            switch result {
            case .success(let data):
                if data.success == false, let statusMsg = data.statusMessage {
                    self?.output?.fetchFailure(error: statusMsg)
                } else if let dataResults = data.results {
                    self?.reviews.append(contentsOf: dataResults)
                    self?.totalPages = data.totalPages
                    self?.currentPage = data.page
                    self?.output?.movieReviewFetched()
                }
            case .failure(let error):
                self?.output?.fetchFailure(error: error.localizedDescription)
            }
        }
    }

    func fetchMovieVideo() {
        service.getMovieVideo(movieID: movieID, responseType: MovieVideoList.self) { [weak self] result in
            switch result {
            case .success(let data):
                if data.success == false, let statusMsg = data.statusMessage {
                    self?.output?.fetchFailure(error: statusMsg)
                } else if let dataResults = data.results {
                    self?.videos.append(contentsOf: dataResults)
                    self?.output?.movieVideoFetched()
                }
            case .failure(let error):
                self?.output?.fetchFailure(error: error.localizedDescription)
            }
        }
    }
}
