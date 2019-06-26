//
//  NowPlayingViewController.swift
//  mFlix
//
//  Created by Tanjim Hossain Sifat on 26/6/19.
//  Copyright © 2019 Tanjim Hossain Sifat. All rights reserved.
//

import UIKit
import MBProgressHUD

class NowPlayingViewController: UIViewController{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let movieTableDataSource = MovieTableDataSource()
    let movieApi = MovieDBApi()
    
    var filteredMovies = [Movie]() {
        didSet {
            movieTableDataSource.movies = filteredMovies
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = movieTableDataSource
        tableView.delegate = self
        fetchDataByApi()
    }

}

extension NowPlayingViewController : MovieDBDelegate {
    func didFinishUpdatingMovies(movies: [Movie]) {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.filteredMovies = movies
    }
    
    func didFailWithError(error: Error) {
        
    }
    
}

extension NowPlayingViewController {
    func fetchDataByApi() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        movieApi.delegate = self
        movieApi.fetchMovies()
    }
}

extension NowPlayingViewController : UITableViewDelegate {
    
}
