//
//  NetworkHelper.swift
//  ShowingGoodMovies
//
//  Created by Mert Ejder on 9.06.2021.
//

import Foundation

class NetworkHelper {
    
    var baseURL = "https://api.themoviedb.org/3/discover/movie?"
    var topMovies = "sort_by=popularity.desc"
    
    enum NetworkError: Error {
        case badURL, requestFailed, unknown
    }
    
    static var requestToken: String? {
        return "&api_key=\(Bundle.main.object(forInfoDictionaryKey: "MovieDB_ApiKey") as? String ?? "")"
    }
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie],NetworkError>) -> () ) {
        let requestURL = "\(baseURL)\(topMovies)&page=\(page)\(NetworkHelper.requestToken!)"
        
        _ = Just.get(requestURL, asyncCompletionHandler: { result in
            if let movieResult = result.content {
                do {
                    let movieObject = try JSONDecoder().decode(MovieResultModel.self, from: movieResult)
                    completion(.success(movieObject.results))
                } catch  {
                    print("Error Decoding")
                }
            }
        })
        
    }
}
