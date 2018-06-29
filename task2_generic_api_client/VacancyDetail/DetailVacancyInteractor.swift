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
            completion(isFavorite)
        }
    }
}
