//
//  VacancyBank.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 26.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

/// Represents a placeholder list of vacancies (no actual API)
class VacancyBank {
    private var vacancies = [Vacancy]()
    
    //
    //  SINGLETON
    //
    static private var instance: VacancyBank?
    
    static public func getInstance() -> VacancyBank{
        if instance == nil {
            instance = VacancyBank()
        }
        
        return instance!
    }
    
    private init(){
        for _ in 1...100 {
            vacancies.append(Vacancy.init(random: true))
        }
    }
    
    //
    // LOGIC
    //
    
    func getAllVacancies() -> [Vacancy] {
        return vacancies
    }
    
    // Return a filtered list of vacancies
    func getVacancies(For filter: String, in field: String) -> [Vacancy] {
        switch field.lowercased() {
        case "title":
            return vacancies.filter({ return $0.title.range(of: filter) != nil })
        case "description":
            return vacancies.filter({ return $0.description?.range(of: filter) != nil })

        default:
            return [Vacancy]()
        }
        
    }
}
