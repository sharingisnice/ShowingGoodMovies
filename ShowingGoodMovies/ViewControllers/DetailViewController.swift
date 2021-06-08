//
//  DetailViewController.swift
//  ShowingGoodMovies
//
//  Created by Mert Ejder on 9.06.2021.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI()  {
        if let movie = movie {
            let imageUrl = "https://image.tmdb.org/t/p/w500\(movie.imageURL ?? "")"
            movieImage.sd_setImage(with: URL(string: imageUrl), completed: nil)
            name.text = movie.name
            score.text = "⭐ \(movie.score)"
            overview.text = movie.description
        }
    }

}
