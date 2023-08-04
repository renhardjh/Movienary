//
//  MovieDetailRouter.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import UIKit

protocol MovieDetailRouterable: AnyObject {
    func presentMovieDetailnView(with movie: Movie)
}

class MovieDetailRouter: Router, MovieDetailRouterable {

    func presentMovieDetailnView(with movie: Movie) {
        let moviewDetailView = MovieDetailDepencyContainer.createModule(for: movie)
        guard let topNav = topNavController else { return }
        topNav.pushViewController(moviewDetailView, animated: true)
    }
}
