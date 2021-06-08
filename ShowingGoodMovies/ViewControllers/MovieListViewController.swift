//
//  ViewController.swift
//  ShowingGoodMovies
//
//  Created by Mert Ejder on 9.06.2021.
//

import UIKit
import SDWebImage

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = MovieListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        getDatas()
    }
    
    
    func setUI() {
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        
    }
    
    
    func getDatas() {
        viewModel.getPopularMovies()
    }
    
    
    //MARK: Segue preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let destination = segue.destination as! DetailViewController
            let movie = viewModel.selectedMovie
            destination.movie = movie
        }
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    func updateMovies() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}


extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.popularMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieData = viewModel.popularMovies[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        
        let imageUrl = "https://image.tmdb.org/t/p/w500\(movieData.imageURL ?? "")"
        cell.movieImage.sd_setImage(with: URL(string: imageUrl))
        cell.name.text = movieData.name
        cell.score.text = "⭐ \(movieData.score)"
        cell.overview.text = movieData.description

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == viewModel.popularMovies.count {
            viewModel.getPopularMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178
    }
    
}

