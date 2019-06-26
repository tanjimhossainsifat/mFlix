//
//  MovieTableDataSource.swift
//  mFlix
//
//  Created by Tanjim Hossain Sifat on 26/6/19.
//  Copyright © 2019 Tanjim Hossain Sifat. All rights reserved.
//

import UIKit

class MovieTableDataSource: NSObject, UITableViewDataSource {
    
    var movies = [Movie]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieTableViewCell
        let movie = movies[indexPath.row]
        movieCell.titleLabel.text = movie.title
        movieCell.overviewLabel.text = movie.overview
        
        if let posterImageURL = movie.posterImageUrlMedium {
            movieCell.posterImageView.setImageWith(posterImageURL, placeholderImage: #imageLiteral(resourceName: "NoPreview"))
        } else {
            movieCell.posterImageView.image = #imageLiteral(resourceName: "NoPreview")
        }
        
        return movieCell
    }

}
