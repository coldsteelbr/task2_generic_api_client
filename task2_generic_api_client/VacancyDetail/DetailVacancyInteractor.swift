//
//  DetailVacancyInteractor.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class DetailVacancyInteractor: BaseInteractor {
    // TODO: Add to favorites
    // TODO: Remove from favorites
    
    func checkForFavorite(vacancy: Vacancy, with completion: @escaping (Bool) -> Void) {
        repository?.isFavorite(vacancy: vacancy) {
            (isFavorite) in
            print("\(#function) is favorite: \(isFavorite)")
            completion(isFavorite)
        }
    }
    
    func toggleFavoriteStateForVacancy(_ vacancy: Vacancy, with completion: @escaping  (Bool) -> Void) {
        repository?.toggleFavoriteStateForVacancy(vacancy) {
            (isFavorite) in
            print("\(#function) is favorite: \(isFavorite)")
            completion(isFavorite)
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
