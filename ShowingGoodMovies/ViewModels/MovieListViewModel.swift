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
    var searchedMovies = [Movie]()
    var movieList = [Movie]()
    var customQuery = ""
    
    let requester = NetworkHelper()
    
    private var pageCount = 0
    private var searchedCount = 0
    
    
    enum LastList {
        case customSearch
        case popular
    }
    
    var lastList = LastList.popular
    
    func getLastKnownList() {
        if lastList == .popular {
            getPopularMovies()
        }
        else if lastList == .customSearch {
            getQueryMovies(query: customQuery)
        }
    }
    
    func getPopularMovies() {
        lastList = .popular
        pageCount += 1
        requester.getMovies(page: pageCount, customQuery: nil) { movieList in
            let newItems = try! movieList.get()
            self.popularMovies.append(contentsOf: newItems)
            self.movieList = self.popularMovies
            self.delegate?.updateMovies()
        }
    }

    func getQueryMovies(query: String) {
        customQuery = query
        lastList = .customSearch
        searchedCount += 1
        requester.getMovies(page: searchedCount, customQuery: query) { movieList in
            let newItems = try! movieList.get()
            self.searchedMovies.append(contentsOf: newItems)
            self.movieList = self.searchedMovies
            self.delegate?.updateMovies()
        }
    }
    
    func clearMovieList() {
        movieList = [Movie]()
        pageCount = 0
        searchedCount = 0
    }
    
}
