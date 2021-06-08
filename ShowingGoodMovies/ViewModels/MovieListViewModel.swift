//
//  MovieListViewModel.swift
//  ShowingGoodMovies
//
//  Created by Mert Ejder on 9.06.2021.
//

import Foundation


import Foundation

protocol MovieListViewModelDelegate {
    func updateMovies()
}

class MovieListViewModel {
    var delegate: MovieListViewModelDelegate?
    var selectedMovie: Movie?
    
    var popularMovies = [Movie]()

    let requester = NetworkHelper()
    
    private var pageCount = 0

    func getPopularMovies() {
        pageCount += 1
        requester.getMovies(page: pageCount) { movieList in
            let newItems = try! movieList.get()
            self.popularMovies.append(contentsOf: newItems)
            self.delegate?.updateMovies()
        }
        
    }

}
