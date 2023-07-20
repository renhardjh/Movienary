//
//  MovieCollectionRouter.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit

protocol MovieCollectionRouterable: AnyObject {
    var container: MovieCollectionDepencyContainer { get set }
    func presentMovieDetailnView(with movie: Movie)
}

class MovieCollectionRouter: Router, MovieCollectionRouterable {
    var container = MovieCollectionDepencyContainer()

    func presentMovieDetailnView(with movie: Movie) {
        let moviewDetailView = container.createModule(for: Genre(id: 1, name: ""))
        guard let topNav = topNavController else { return }
        topNav.pushViewController(moviewDetailView, animated: true)
    }
}
