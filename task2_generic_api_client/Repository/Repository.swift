//
//  Repository.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 26.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class Repository {
    //
    //
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
    
    func getVacanciesForRequest(_ request: Request, with completion: @escaping (RequestResult)->()) {
        // Executing request in separate thread
        // and then calling completion()
        request.execute {
            (result) in
            
            DispatchQueue.global(qos: .userInteractive).async {
                completion(result)
            }
        }
    }
    
    func getAllFavorites(with completion: ([Vacancy])->()) {
        // trying to get everything from favorites
        // in a separate thread
        // then calling completion()
    }
}
