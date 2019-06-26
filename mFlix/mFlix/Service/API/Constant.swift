//
//  Constant.swift
//  mFlix
//
//  Created by Tanjim Hossain Sifat on 26/6/19.
//  Copyright © 2019 Tanjim Hossain Sifat. All rights reserved.
//

import UIKit

class Constant {
    
    private static let baseUrl: String = "https://api.themoviedb.org/3/movie/now_playing"
    private static let imageBaseUrl: String = "https://image.tmdb.org/t/p/"
    private static let apiKey: String = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    static func getBaseUrl() -> String {
        return baseUrl
    }
    
    static func getImageBaseUrl() -> String {
        return imageBaseUrl
    }
    
    static func getApiKey() -> String {
        return apiKey
    }
    
    static func getApiUrl() -> String {
        return "\(getBaseUrl())?api_key=\(getApiKey())"
    }
}
