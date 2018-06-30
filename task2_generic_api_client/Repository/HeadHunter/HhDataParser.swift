//
//  HhDataParser.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 30.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class HhDataParser: DataParserProtocol {
    
    func fetchVacancyListFrom(JSON json: Data) -> RequestResult {
        do{
            let jsonObject = try JSONSerialization.jsonObject(with: json, options: [])
            print(jsonObject)
            
            //
            // parsing JSON for vacancies
            //
            guard let jsonDictionary  = jsonObject as? [AnyHashable:Any],
                let vacancies = jsonDictionary["items"] as? [[String:Any]] else {
                    return .error(NSError(domain: "Fail", code: 1, userInfo: nil))
            }
            
            var vacancyList = [Vacancy]()
            //
            //  Populating list of Vacancies TODO: Total convertion
            //
            for item in vacancies {
                let title = item["name"] as? String
                let vacancy = Vacancy(title: title!, description: "", date: Date(), salary: Decimal(0), employer: Employer.genericEmployer(), experience: "", url: "http://vacancy.random")
                vacancyList.append(vacancy)
            }
            
            return .success(vacancyList)
        } catch {
            return .error(error)
        }
        
    }
    
    
}
