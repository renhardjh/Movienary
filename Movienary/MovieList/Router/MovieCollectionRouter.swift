//
//  MovieCollectionRouter.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit

protocol MovieCollectionRouterable: AnyObject {
    func presentMovieDetailnView(with movie: Movie)
}

class MovieCollectionRouter: Router, MovieCollectionRouterable {

    func presentMovieDetailnView(with movie: Movie) {
        let movieDetailView = MovieDetailDepencyContainer.createModule(for: movie)
        guard let topNav = topNavController else { return }
        topNav.pushViewController(movieDetailView, animated: true)
    }
}
