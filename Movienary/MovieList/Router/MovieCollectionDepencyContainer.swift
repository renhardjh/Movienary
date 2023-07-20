//
//  MovieCollectionDepencyContainer.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import UIKit

class MovieCollectionDepencyContainer {

    func createModule(for genre: Genre) -> UIViewController {
        let view = MovieCollectionViewController()
        let service = MovieService()
        let router = MovieCollectionRouter()

        let interactor = MovieCollectionInteractor(service: service)
        interactor.genre = genre
        
        let presenter = MovieCollectionPresenter(
            view: view,
            router: router,
            interactor: interactor
        )
        interactor.output = presenter
        view.presenter = presenter

        return view
    }
}
