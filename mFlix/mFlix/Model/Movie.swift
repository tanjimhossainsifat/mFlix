//
//  Movie.swift
//  mFlix
//
//  Created by Tanjim Hossain Sifat on 26/6/19.
//  Copyright © 2019 Tanjim Hossain Sifat. All rights reserved.
//

import UIKit

class Movie {
    var title : String?
    var rating : Double?
    var overview : String?
    var releaseDate : String?
    
    var posterImageUrlLow : URL?
    var posterImageUrlMedium : URL?
    var posterImageUrlHigh : URL?
    
    var backdropImageUrlLow : URL?
    var backdropImageUrlMedium : URL?
    var backdropImageUrlHigh : URL?
    
    init(title : String?, rating : Double? , overview : String?, releaseDate : String?) {
        self.title = title
        self.rating = rating
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    init(dictionary : [String : Any?]) {
        title = dictionary["title"] as? String
        rating = dictionary["vote_average"] as? Double
        overview = dictionary["overview"] as? String
        releaseDate = dictionary["release_date"] as? String
        
        if let posterImagePath = dictionary["poster_path"] as? String {
            posterImageUrlMedium = URL(string: Constant.getImageBaseUrl() + "w500" + posterImagePath)
            posterImageUrlHigh = URL(string: Constant.getImageBaseUrl() + "original" + posterImagePath)
            posterImageUrlLow = URL(string: Constant.getImageBaseUrl() + "w45" + posterImagePath)
        }
        
        if let backdropPath = dictionary["backdrop_path"] as? String {
            backdropImageUrlMedium = URL(string: Constant.getImageBaseUrl() + "w500" + backdropPath)
            backdropImageUrlHigh = URL(string: Constant.getImageBaseUrl() + "original" + backdropPath)
            backdropImageUrlLow = URL(string: Constant.getImageBaseUrl() + "w45" + backdropPath)
        }
        
    }
}

extension Movie {
    class func movies(movieList : [[String : Any?]]) -> [Movie] {
        return movieList.map{Movie(dictionary: $0)}
    }
}
