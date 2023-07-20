//
//  GenreCollectionDepencyContainer.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import UIKit

class GenreCollectionDepencyContainer {

    func createModule() -> UIViewController {
        let view = GenreCollectionViewController()
        let service = MovieService()
        let router = GenreCollectionRouter()
        let interactor = GenreCollectionInteractor(service: service)
        let presenter = GenreCollectionPresenter(
            view: view,
            router: router,
            interactor: interactor
        )
        interactor.output = presenter
        view.presenter = presenter

        return view
    }
}
