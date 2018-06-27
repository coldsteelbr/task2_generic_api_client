//
//  InMemoryRequest.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 27.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class InMemoryRequest: Request {
    
    let filter: String
    let field: String
    
    init(filter: String, field: String) {
        self.filter = filter
        self.field = field
    }
    
    /// Gets vacancies from the in-memory bank
    func execute(with completion: @escaping (RequestResult) -> Void) {
        let resultArray = VacancyBank.getInstance().getVacancies(For: filter, in: field)
        
        completion(RequestResult.success(resultArray))
    }
    
}