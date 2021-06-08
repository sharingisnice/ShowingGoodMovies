//
//  ViewController.swift
//  ShowingGoodMovies
//
//  Created by Mert Ejder on 9.06.2021.
//

import UIKit

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
        
    }
    
    func getDatas() {
        
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

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath)
        
        return cell
    }
    
    
}

