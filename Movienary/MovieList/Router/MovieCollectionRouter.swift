//
//  MovieCollectionRouter.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit

protocol MovieCollectionRouterable: AnyObject {
    var container: MovieDetailDepencyContainer { get set }
    func presentMovieDetailnView(with movie: Movie)
}

class MovieCollectionRouter: Router, MovieCollectionRouterable {
    var container = MovieDetailDepencyContainer()

    func presentMovieDetailnView(with movie: Movie) {
        let movieDetailView = container.createModule(for: movie)
        guard let topNav = topNavController else { return }
        topNav.pushViewController(movieDetailView, animated: true)
    }
}
