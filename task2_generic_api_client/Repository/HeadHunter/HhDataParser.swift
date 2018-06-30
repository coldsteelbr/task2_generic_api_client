//
//  HhDataParser.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 30.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class HhDataParser: DataParserProtocol {
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return df
        
    }()
    
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
                // title
                let title = item["name"] as? String
                // url
                let url = item["url"] as? String
                
                //
                //  date
                //
                let published_at = item["published_at"] as? String
                let date = dateFormatter.date(from: published_at!)
                
                //
                // description
                //
                let snippet = item["snippet"] as? [String:Any]
                
                var requirement = ""
                if let req = snippet!["requirement"] as? String {
                    requirement = req
                }
                
                var responsibility = ""
                if let res = snippet!["responsibility"] as? String {
                    responsibility = res
                }
                
                let description = "\(requirement)\n\nResponsibility:\n\(responsibility)"
                
                //
                // salary
                //
                var salary_from: Decimal?
                var salary_to: Decimal?
                if let salary = item["salary"] as? [String:Any] {
                    // to
                    if let s_to = salary["to"] as? String {
                        if let d_to = Decimal(string: s_to) {
                            salary_to = d_to
                        }
                    }
                    
                    // from
                    if let s_from = salary["from"] as? String {
                        if let d_from = Decimal(string: s_from) {
                            salary_from = d_from
                        }
                    }
                }
                
                
                //
                // EMPLOYER
                //
                var actualEmployer = Employer.genericEmployer()
                if let employer = item["employer"] as? [String:Any] {
                    let employerName = employer["name"] as? String
                    let employerUrl = employer["url"] as? String
                    let employerLogos = employer["logo_urls"] as? [String: Any]
                    
                    guard let e_name = employerName,
                          let e_url = employerUrl
                        else {
                        return .error(NSError(domain: "Fail", code: 1, userInfo: nil))
                    }
                    
                    actualEmployer = Employer(Name: e_name, Description: e_url, LogoUrl: nil)
                    
                }
                
                //
                //  Building vacancy
                //
                let vacancy = Vacancy(title: title!,
                                      description: description,
                                      date: date!,
                                      salary_from: salary_from,
                                      salary_to: salary_to,
                                      employer: actualEmployer,
                                      experience: "",
                                      url: url!)
                vacancyList.append(vacancy)
            }
            
            return .success(vacancyList)
        } catch {
            return .error(error)
        }
        
    }
    
    
}
