//
//  Repository.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 26.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation
import UIKit

class Repository {
    //
    //  HTTP session
    //
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    //
    //  Singleton
    //
    private static var instance: Repository?
    
    public static func getInstance() -> Repository{
        if instance == nil {
            instance = Repository()
        }
        
        return instance!
    }
    
    private init() {
        
    }
    
    //
    //  Commands
    //
    /// Gets array of vacancy according to the resuest. API HH
    func getVacanciesForRequest(_ request: Request, with completion: @escaping (VacanciesRequestResult)->()) {
        // Executing request in separate thread
        // and then calling completion()
        request.execute {
            (result) in
            
            DispatchQueue.global(qos: .userInteractive).async {
                completion(result)
            }
        }
    }
    
    //
    // for favorites // TODO: use CoreData
    //
    
    /// Gets all favorite vacancies as an array (in-memory)
    func getAllFavorites(with completion: @escaping ([Vacancy])->()) {
        // trying to get everything from favorites
        // in a separate thread
        // then calling completion()
        DispatchQueue.global(qos: .userInteractive).async {
            sleep(1)
            completion(FavoritesBank.getInstance().getAllVacancies())
        }
    }
    
    /// Checks out if the vacancy is in favorites
    func isFavorite(vacancy: Vacancy, with completion: @escaping (Bool)->()) {
        // TODO: use CoreData
        DispatchQueue.global(qos: .userInteractive).async {
            completion(FavoritesBank.getInstance().contains(vacancy))
        }
    }
    
    /// Inverts Vacancy's favorite state:
    /// - adds to favorites if it wasn't
    /// - deletes from favorites if it was there
    func toggleFavoriteStateForVacancy(_ vacancy: Vacancy, with completion: @escaping (Bool)->()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let bank = FavoritesBank.getInstance()
            // toggling
            if bank.contains(vacancy) {
               bank.removeVacancy(vacancy)
            } else {
                bank.addVacancy(vacancy)
            }
            // sending result contains now or not
            completion(FavoritesBank.getInstance().contains(vacancy))
        }
    }
    
    //
    //  Getting Image
    //
    func getImageForUrl(_ url:URL, with completion: @escaping(ImageResult) -> Void){
        
        DispatchQueue.global(qos: .userInteractive).async {
            // trying to get image from cache by key
            let logoKey = (url.absoluteString as NSString).lastPathComponent
            if let image = ImageCachingBank.getInstance().image(forKey: logoKey) {
                completion(.success(image))
                return
            }
            
            // else trying to download
            
            let request = URLRequest(url: url)
            let task = self.session.dataTask(with: request) {
                (data, response, error) -> Void in
                // Delay intended, to demonstrate async lazy loading
                usleep(333000)
                
                // trying to build image
                let result = self.processingImageRequest(data: data, error: error)
                
                // adding to cache
                if case let .success(image) = result {
                    ImageCachingBank.getInstance().setImage(image, forKey: logoKey)
                }
                
                // returning result
                completion(result)
            }
            task.resume()
            
        }
    }
    
    /// creates and returns actual UIImage from Data
    private func processingImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                
                // can't create image
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(PhotoError.imageCreationError)
                }
        }
        
        return .success(image)
    }
}
