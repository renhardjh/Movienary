//
//  MovieDetailRouter.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import UIKit

protocol MovieDetailRouterable: AnyObject {
    var container: MovieDetailDepencyContainer { get set }
    func presentMovieDetailnView(with movie: Movie)
}

class MovieDetailRouter: Router, MovieDetailRouterable {
    var container = MovieDetailDepencyContainer()

    func presentMovieDetailnView(with movie: Movie) {
        let moviewDetailView = container.createModule(for: movie)
        guard let topNav = topNavController else { return }
        topNav.pushViewController(moviewDetailView, animated: true)
    }
}
