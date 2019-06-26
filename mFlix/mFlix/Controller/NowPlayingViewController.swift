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
    
    var tableViewRefreshControl = UIRefreshControl()
    
    let movieTableDataSource = MovieTableDataSource()
    let movieApi = MovieDBApi()
    let databaseHelper = DatabaseHelper()
    
    var movies = [Movie]() {
        didSet {
            filteredMovies = movies
        }
    }
    var filteredMovies = [Movie]() {
        didSet {
            movieTableDataSource.movies = filteredMovies
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControls()
        tableView.dataSource = movieTableDataSource
        tableView.delegate = self
        searchBar.delegate = self
        fetchDataByApi()
    }

}

extension NowPlayingViewController : MovieDBDelegate {
    func didFinishUpdatingMovies(movies: [Movie]) {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.movies = movies
        DispatchQueue.main.async {
            self.tableViewRefreshControl.endRefreshing()
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.tableViewRefreshControl.endRefreshing()
        }
    }
    
}

extension NowPlayingViewController {
    @objc func fetchDataByApi() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        movieApi.delegate = self
        movieApi.fetchMovies()
    }
}

extension NowPlayingViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        databaseHelper.save(movie: movie)
    }
}

extension NowPlayingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = searchText.isEmpty ? movies :  movies.filter {($0.title ?? "").range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        filteredMovies = movies
        searchBar.resignFirstResponder()
    }
}

extension NowPlayingViewController {
    func setupRefreshControls() {
        tableViewRefreshControl.addTarget(self, action: #selector(self.fetchDataByApi), for: .valueChanged)
        tableView.insertSubview(tableViewRefreshControl, at: 0)
    }
}
