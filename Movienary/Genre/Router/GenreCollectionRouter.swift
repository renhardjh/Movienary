//
//  GenreCollectionRouter.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit

protocol GenreCollectionRouterable: AnyObject {
    func presentMovieCollectionView(with genre: Genre)
}

class GenreCollectionRouter: Router, GenreCollectionRouterable {

    func presentMovieCollectionView(with genre: Genre) {
        let movieCollectionView = MovieCollectionDepencyContainer.createModule(for: genre)
        guard let topNav = topNavController else { return }
        topNav.pushViewController(movieCollectionView, animated: true)
    }
}
