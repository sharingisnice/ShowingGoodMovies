//
//  Movie.swift
//  ShowingGoodMovies
//
//  Created by Mert Ejder on 9.06.2021.
//

import Foundation

struct Movie: Codable {
    let name: String
    let score: Float
    let date: String
    let description: String
    let image: Data?
    let imageURL: String?
    let id: Int?
    
    //Here we fit our model to match with the TMDB data style
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case score = "vote_average"
        case date = "release_date"
        case description = "overview"
        case image = "image"
        case imageURL = "poster_path"
        case id = "id"
    }
    
}
