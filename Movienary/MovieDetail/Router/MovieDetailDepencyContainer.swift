//
//  MovieDetailDepencyContainer.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import UIKit

class MovieDetailDepencyContainer: AnyRouterContainer {

    static func createModule(for bundle: Any?) -> UIViewController {
        guard let movie = bundle as? Movie else {
            return UIViewController()
        }
        let view = MovieDetailViewController()
        let service = MovieService()
        let router = MovieDetailRouter()

        let interactor = MovieDetailInteractor(service: service)
        interactor.movie = movie

        let presenter = MovieDetailPresenter(
            view: view,
            router: router,
            interactor: interactor
        )
        interactor.output = presenter
        view.presenter = presenter

        return view
    }
}
