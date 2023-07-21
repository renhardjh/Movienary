//
//  MovieDetailDepencyContainer.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import UIKit

class MovieDetailDepencyContainer {

    func createModule(for movie: Movie) -> UIViewController {
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
