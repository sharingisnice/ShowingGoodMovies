//
//  MovieResultModel.swift
//  ShowingGoodMovies
//
//  Created by Mert Ejder on 9.06.2021.
//

import Foundation

struct MovieResultModel: Codable {
    let page: Int
    let results: [Movie]
}
