//
//  DatabaseHelper.swift
//  mFlix
//
//  Created by Tanjim Hossain Sifat on 27/6/19.
//  Copyright © 2019 Tanjim Hossain Sifat. All rights reserved.
//

import UIKit
import CoreData

class DatabaseHelper : NSObject {

    func save(movie : Movie) -> Void {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: managedContext)!
        
        let movieObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        movieObject.setValue(movie.title, forKey: "title")
        movieObject.setValue(movie.overview, forKey: "overview")
        movieObject.setValue(movie.rating, forKey: "rating")
        movieObject.setValue(movie.releaseDate, forKey: "releaseDate")
        
        do {
            try managedContext.save()
            print("\(movie) saved to database")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetch() -> [Movie] {
        
        var movies = [Movie]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return movies
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as? String
                let overview = data.value(forKey: "overview") as? String
                let rating = data.value(forKey: "rating") as? Double
                let releaseDate = data.value(forKey: "releaseDate") as? String
                let movie = Movie(title: title, rating: rating, overview: overview, releaseDate: releaseDate)
                movies.append(movie)
            }
        } catch {
            print("Failed to fetch data from database")
        }
        
        return movies
    }
}
