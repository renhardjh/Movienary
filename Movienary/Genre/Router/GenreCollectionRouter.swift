//
//  GenreCollectionRouter.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit

protocol GenreCollectionRouterable: AnyObject {
    var container: MovieCollectionDepencyContainer { get set }
    func presentMovieCollectionView(with genre: Genre)
}

class GenreCollectionRouter: Router, GenreCollectionRouterable {
    var container = MovieCollectionDepencyContainer()

    func presentMovieCollectionView(with genre: Genre) {
        let movieCollectionView = container.createModule(for: genre)
        guard let topNav = topNavController else { return }
        topNav.pushViewController(movieCollectionView, animated: true)
    }
}
