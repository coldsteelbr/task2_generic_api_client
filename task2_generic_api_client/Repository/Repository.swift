//
//  Repository.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 26.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class Repository {
    func getVacanciesForRequest(_ request: Request, with completion: (RequestResult)->()) {
        // Executing request in separate thread
        // and then calling completion()
    }
    
    func getAllFavorites(with completion: ([Vacancy])->()) {
        // trying to get everything from favorites
        // in a separate thread
        // then calling completion()
    }
}
