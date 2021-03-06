//
//  InMemoryRequest.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 27.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation
/// Represent a placeholder in-memory request. Return data from VacancyBank (No actual API)
class InMemoryRequest: Request {
    
    let filter: String
    let field: String
    
    init(filter: String, field: String) {
        self.filter = filter
        self.field = field
    }
    
    /// Gets vacancies from the in-memory bank
    func execute(with completion: @escaping (VacanciesRequestResult) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            print("\(#function) Searching for \(self.filter) in vacancy bank")
            let resultArray = VacancyBank.getInstance().getVacancies(For: self.filter, in: self.field)
            sleep(1)
            completion(VacanciesRequestResult.success(resultArray))
        }
    }
    
}
