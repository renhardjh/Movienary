//
//  AlertType.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

enum AlertType {
    case error
    case info

    var title: String {
        switch self {
        case .error:
            return "Failed"
        case .info:
            return "Information"
        }
    }

    var action: String {
        switch self {
        case .error:
            return "Try Again"
        case .info:
            return "Ok"
        }
    }
}

enum UniversalMessage {
    case emptyGenre
    case emptyMovie

    var description: String {
        switch self {
        case .emptyGenre:
            return "Oops no genre data, please try again later"
        case .emptyMovie:
            return "Oops no movie data, please try again later"
        }
    }
}
