//
//  GenreCollectionDepencyContainer.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import UIKit

protocol AnyRouterContainer {
    static func createModule(for bundle: Any?) -> UIViewController
}

class GenreCollectionDepencyContainer: AnyRouterContainer {

    static func createModule(for bundle: Any? = nil) -> UIViewController {
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
