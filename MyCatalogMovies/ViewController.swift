//
//  ViewController.swift
//  MyCatalogMovies
//
//  Created by Ana Brito Souza on 16/02/22.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    
    fileprivate func startAnimationView() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimationView()
    }

}
