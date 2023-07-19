//
//  ItemPresentation.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

protocol ItemPresentation {
    func item<T>(at: Int) -> T?
}
