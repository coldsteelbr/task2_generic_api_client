//
//  VacancyListInteractor.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class VacancyListInteractor: BaseInteractor{
    
    func searchWith(searchString: String, with completion: @escaping (RequestResult)->Void){
        //
        //  Creating a request
        //
        let request = InMemoryRequest(filter: searchString, field: "title")
        
        //
        //  Sending request
        //
        repository!.getVacanciesForRequest(request) {
            (result) in
            
            completion(result)
        }
    }
    
}
