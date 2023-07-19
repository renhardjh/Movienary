//
//  NetworkEndpointMovie.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

enum NetworkEndpointMovie: NetworkEndpoint {
    case getGenreList

    var value: String {
        switch self {
        case .getGenreList:
            return "3/genre/movie/list"
        }
    }
}
