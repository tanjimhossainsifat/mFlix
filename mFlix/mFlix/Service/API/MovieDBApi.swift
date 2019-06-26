//
//  MovieDBApi.swift
//  mFlix
//
//  Created by Tanjim Hossain Sifat on 26/6/19.
//  Copyright © 2019 Tanjim Hossain Sifat. All rights reserved.
//

import UIKit
import CoreData


enum MovieDBErrors: Error {
    case networkFail(description: String)
    case jsonSerializationFail
    case dataNotReceived
    case castFail
    case internalError
    case unknown
}

extension MovieDBErrors: LocalizedError {
    public var errorDescription: String? {
        let defaultMessage = "Unknown error!"
        let internalErrorMessage = "Something's wrong! Please contact our support team."
        switch self {
        case .networkFail(let localizedDescription):
            print(localizedDescription)
            return localizedDescription
        case .jsonSerializationFail:
            return internalErrorMessage
        case .dataNotReceived:
            return internalErrorMessage
        case .castFail:
            return internalErrorMessage
        case .internalError:
            return internalErrorMessage
        case .unknown:
            return defaultMessage
        }
    }
}

protocol MovieDBDelegate: NSObjectProtocol {
    func didFinishUpdatingMovies(movies : [Movie]) -> Void
    func didFailWithError(error: Error) -> Void
}

class MovieDBApi {
    
    var delegate: MovieDBDelegate?
    
    func fetchMovies() {
        var urlRequest = URLRequest(url: URL(string: Constant.getApiUrl())!)
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: urlRequest, completionHandler:
        { (data, response, error) in
            
            guard error == nil else {
                self.delegate?.didFailWithError(error: MovieDBErrors.networkFail(description: error!.localizedDescription))
                print("TheMovieDBApi: \(error!.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                self.delegate?.didFailWithError(error: MovieDBErrors.unknown)
                print("TheMovieDBApi: Unknown error. Could not get response!")
                return
            }
            
            guard response.statusCode == 200 else {
                self.delegate?.didFailWithError(error: MovieDBErrors.internalError)
                print("TheMovieDBApi: Response code was either 401 or 404.")
                return
            }
            
            guard let data = data else {
                self.delegate?.didFailWithError(error: MovieDBErrors.dataNotReceived)
                print("TheMovieDBApi: Could not get data!")
                return
            }
            
            do {
                let movies = try self.parseMovies(with: data)
                self.delegate?.didFinishUpdatingMovies(movies: movies)
            } catch (let error) {
                self.delegate?.didFailWithError(error: error)
                print("TheMovieDBApi: Some problem occurred during JSON serialization.")
                return
            }
            
        });
        task.resume()
    }
    
    func parseMovies(with data: Data) throws -> [Movie] {
        do {
            
            guard let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                throw MovieDBErrors.castFail
            }
            
            guard let movieDictionaries = responseDictionary["results"] as? [[String : Any?]] else {
                print("TheMovieDBApi: Movie dictionary not found.")
                throw MovieDBErrors.unknown
            }
            
            return Movie.movies(movieList: movieDictionaries)
            
        } catch (let error) {
            print("TheMovieDBApi: \(error.localizedDescription)")
            throw error
        }
    }

}
