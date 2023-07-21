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
        case moviedbAPI
        case moviedbImage(type: PosterType, pathName: String)

        var value: String {
            switch self {
            case .moviedbAPI:
                return "https://api.themoviedb.org"
            case .moviedbImage(let type, let pathName):
                return "https://image.tmdb.org" + type.path + pathName
            }
        }
    }
}

enum PosterType {
    case preview
    case original

    var path: String {
        switch self {
        case .preview:
            return "/t/p/w500"
        case .original:
            return "/t/p/original"
        }
    }
}
