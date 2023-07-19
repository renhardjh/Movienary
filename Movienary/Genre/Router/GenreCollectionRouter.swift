//
//  GenreCollectionRouter.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import UIKit

class GenreCollectionRouter {
    static func createModule() -> UIViewController {
        let viewController = GenreCollectionViewController()
        let service = MovieService()
        let interactor = GenreCollectionInteractor(service: service)
        let presenter = GenreCollectionPresenter(view: viewController, interactor: interactor)
        interactor.output = presenter
        viewController.presenter = presenter

        return viewController
    }
}
