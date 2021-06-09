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
    let dateFormatterGet = DateFormatter()
    let dateFormatterShow = DateFormatter()
    let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        getDatas()
    }
    
    
    func setUI() {
        tableView.dataSource = self
        tableView.delegate = self

        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        viewModel.delegate = self
        
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        dateFormatterShow.dateFormat = "MMMM yyyy"
        
    
    }
    
    
    func getDatas() {
        viewModel.getPopularMovies()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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


extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        
        if let text = text {
            if text.count > 1 {
                viewModel.clearMovieList()
                viewModel.getQueryMovies(query: text)
            }
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
        
        if viewModel.movieList.isEmpty {
            return UITableViewCell()
        }

        let movieData = viewModel.movieList[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        
        let imageUrl = "https://image.tmdb.org/t/p/w500\(movieData.imageURL ?? "")"
        cell.movieImage.sd_setImage(with: URL(string: imageUrl))
        cell.name.text = movieData.name
        cell.score.text = "⭐ \(movieData.score)"
        cell.overview.text = movieData.description
        
        if let dateData = dateFormatterGet.date(from: movieData.date) {
            cell.date.text = dateFormatterShow.string(from: dateData)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == viewModel.movieList.count {
            viewModel.getLastKnownList()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedMovie = viewModel.movieList[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
}

