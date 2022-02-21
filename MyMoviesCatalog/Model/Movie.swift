//
//  Movie.swift
//  MyMoviesCatalog
//
//  Created by Ana Brito Souza on 21/02/22.
//

import Foundation
import Alamofire

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

class MovieModel {
    
    static func getTrendingMovies() -> [Movie] {
        var movies: [Movie] = []
        AF.request("https://api.themoviedb.org/3/trending/movie/week?api_key=8eb6c777ec4afbd830c7340eca705fd1&language=pt-BR")
            .responseDecodable(of: MovieResponse.self) { response in
                if case .success(let result) = response.result {
                    movies = (result as MovieResponse).results
                }
            }
        return movies
    }
    
    static func fetchMovieDetail(idMovie: Int) -> MovieDetail {
        var movieDetail: MovieDetail!
        
        AF.request("https://api.themoviedb.org/3/movie/\(idMovie)?api_key=8eb6c777ec4afbd830c7340eca705fd1&language=pt-BR")
            .responseDecodable(of: MovieDetail.self){ response in
            if case .success(let result) = response.result {
                movieDetail = (result as MovieDetail)
            }
        }
        return movieDetail
    }
}

