//
//  Network.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

final class Network {

    enum Method: String, CaseIterable {
        case get, put, post, delete, head, patch
    }

    enum Host {
        case moviedb

        var value: String {
            switch self {
            case .moviedb:
                return "https://api.themoviedb.org"
            }
        }
    }
}
