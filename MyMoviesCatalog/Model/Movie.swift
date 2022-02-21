//
//  Movie.swift
//  MyMoviesCatalog
//
//  Created by Ana Brito Souza on 21/02/22.
//

import Foundation

struct Movie : Decodable {
    let poster_path: String
    let title: String
    let overview: String
    let id: Int
    let backdrop_path: String
}

struct MovieResponse : Decodable {
    let results: [Movie]
}

struct MovieDetail: Decodable {
    let backdrop_path: String
    let release_date: String
    let vote_average: Double
    let overview: String
}

