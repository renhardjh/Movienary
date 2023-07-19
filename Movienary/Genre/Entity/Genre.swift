//
//  Genre.swift
//  Movienary
//
//  Created by RenhardJH on 19/07/23.
//

import Foundation

struct GenreList: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
