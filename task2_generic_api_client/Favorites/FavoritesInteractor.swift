//
//  FavoritesInteractor.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class FavoritesInteractor: BaseInteractor {
    func getAllFavorites(with completion: @escaping ([Vacancy]) -> Void ) {
        repository?.getAllFavorites() {
            (favorites) in
            
            completion(favorites)
        }
    }
    
    func getImageForUrl(_ urlString: String, with completion: @escaping (ImageResult)->Void) {
        if let url =  URL(string: urlString) {
            repository!.getImageForUrl(url){
                (result) in
                
                completion(result)
            }
        } else {
            completion(.failure(NSError(domain: "No URL", code: 1, userInfo: nil)))
        }
    }
}
