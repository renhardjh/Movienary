//
//  GenreCollectionViewInterface.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

protocol GenreCollectionViewInterface: AnyObject {
    func displayLoading()
    func hideLoading()
    func displayGenres()
    func displayAlert(type: AlertType, message: String)
}
