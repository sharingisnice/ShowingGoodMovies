//
//  DetailViewController.swift
//  ShowingGoodMovies
//
//  Created by Mert Ejder on 9.06.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI()  {
        if let movie = movie {
//            movieImage.image = movie.image
            name.text = movie.name
        }
    }

}
