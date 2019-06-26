//
//  Movie.swift
//  mFlix
//
//  Created by Tanjim Hossain Sifat on 26/6/19.
//  Copyright © 2019 Tanjim Hossain Sifat. All rights reserved.
//

import UIKit

class Movie {
    private var title : String?
    private var rating : Double?
    private var overview : String?
    private var releaseDate : String?
    
    private var posterImageUrlLow : URL?
    private var posterImageUrlMedium : URL?
    private var posterImageUrlHigh : URL?
    
    private var backdropImageUrlLow : URL?
    private var backdropImageUrlMedium : URL?
    private var backdropImageUrlHigh : URL?
    
    
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
