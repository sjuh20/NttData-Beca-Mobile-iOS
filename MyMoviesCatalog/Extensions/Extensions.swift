//
//  Extensions.swift
//  MyMoviesCatalog
//
//  Created by Ana Brito Souza on 21/02/22.
//

import UIKit
import Alamofire
import AlamofireImage

// Extensao para setar uma imagem em um UIImageView
extension UIImageView {
    func setImageFromURL(url: String) {
        
        let baseUrlImage = "https://image.tmdb.org/t/p/w500" + url
        
        AF.request(baseUrlImage).responseImage { response in
            if case .success(let image) = response.result {
                self.image = image
            }
        }
    }
}
