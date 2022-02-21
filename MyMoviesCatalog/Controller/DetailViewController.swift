//
//  DetailViewController.swift
//  MyMoviesCatalog
//
//  Created by Ana Brito Souza on 21/02/22.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    var movieDetail: MovieDetail!
    var movie: Movie!
    
    //MARK - IBOulets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var realeaseDateLabel: UILabel!
    @IBOutlet var imdbLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie.title
        fetchMovieDetail()
    }
    
    //    Uma função que faz uma requisicao de api e recebe um json que é decodificada e carregada
    //    na variavel response, que pode ter estado de sucesso ou carregada com o objeto error
    //    no caso de sucesso eu pego o response.result, e faco um casting para movieDetail e seto a minha
    //    self.MovieDetail
    
    private func fetchMovieDetail() {
        
        
        AF.request("https://api.themoviedb.org/3/movie/\(self.movie.id)?api_key=8eb6c777ec4afbd830c7340eca705fd1&language=pt-BR")
            .responseDecodable(of: MovieDetail.self){ response in
            if case .success(let result) = response.result {
                self.movieDetail = (result as MovieDetail)
                self.realeaseDateLabel.text = self.movieDetail.release_date
                self.imdbLabel.text = "\(self.movieDetail.vote_average) (IMDb)"
                self.overviewLabel.text = self.movieDetail.overview
                self.posterImageView.setImageFromURL(url: self.movieDetail.backdrop_path)
            }
        }
    }
}
