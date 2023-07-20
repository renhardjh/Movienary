//
//  MovieCollectionViewInterface.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

protocol MovieCollectionViewInterface: AnyObject {
    func displayLoading()
    func hideLoading()
    func displayMovies()
    func displayAlert(type: AlertType, message: String)
}
