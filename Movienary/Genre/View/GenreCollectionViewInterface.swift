//
//  GenreCollectionViewInterface.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

protocol GenreCollectionViewInterface: AnyObject {
    func displayGenres()
    func displayError(message: String)
}
