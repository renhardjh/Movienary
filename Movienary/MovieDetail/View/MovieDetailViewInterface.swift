//
//  MovieDetailViewInterface.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import Foundation

protocol MovieDetailViewInterface: AnyObject, BaseViewInterface {
    func displayLoading()
    func hideLoading()
    func displayMovieDetail()
}
