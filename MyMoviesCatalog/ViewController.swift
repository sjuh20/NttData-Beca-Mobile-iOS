//
//  ViewController.swift
//  MyMoviesCatalog
//
//  Created by Ana Brito Souza on 20/02/22.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {
    
    var movies: [Movie] = []
    
    // Inicializacao Manual da CollectionView
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        callToTMDB()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let dest = segue.destination as? DetailViewController, let index =
                collectionView.indexPathsForSelectedItems?.first {
                dest.movie = movies[index.row]
            }
        }
    }
    
    private func callToTMDB() {
        AF.request("https://api.themoviedb.org/3/trending/movie/week?api_key=8eb6c777ec4afbd830c7340eca705fd1&language=pt-BR").responseDecodable(of: MovieResponse.self){ response in
            if case .success(let result) = response.result {
                self.movies = (result as MovieResponse).results
            }
            self.view.addSubview(self.collectionView)
        }
    }
}

// Extensao para trabalhar com a CollectionView
extension ViewController: UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            fatalError()
        }
        
        // Usando a funcao de extensao
        cell.imageView.setImageFromURL(url: self.movies[indexPath.row].poster_path)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("item at \(indexPath.section)/\(indexPath.item) tapped")
//        showToast(controller: self, message : movies[indexPath.item].title, seconds: 2.0)
        
        performSegue(withIdentifier: "detailSegue", sender: self)
        
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15

        controller.present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
                        IndexPath) -> CGSize {
        return CGSize(width: (view.frame.self.size.width/2)-10,
                      height: CGFloat(300.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}
