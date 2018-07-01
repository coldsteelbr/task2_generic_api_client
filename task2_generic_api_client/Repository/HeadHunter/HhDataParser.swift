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
    
    func fetchVacancyListFrom(JSON json: Data) -> VacanciesRequestResult {
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
                    if let s_to = salary["to"] as? Double {
                        salary_to = Decimal(s_to)
                    }
                    
                    // from
                    if let s_from = salary["from"] as? Double {
                        salary_from =  Decimal(s_from)
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
                    
                    var logo_url = ""
                    if let logos = employerLogos {
                        let logo_90 = logos["90"] as! String
                        logo_url = logo_90
                    }
                    actualEmployer = Employer(Name: e_name, Description: e_url, LogoUrl: logo_url)
                    
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
    
    func fetchEmployerFrom(JSON json: Data) -> EmployerRequestResult {
        do{
            let jsonObject = try JSONSerialization.jsonObject(with: json, options: [])
            print(jsonObject)
            
            //
            // parsing JSON for employer
            //
            guard let jsonDictionary  = jsonObject as? [AnyHashable:Any],
                let name = jsonDictionary["name"] as? String,
                let description = jsonDictionary["description"] as? String
            else {
                    return .error(NSError(domain: "Fail", code: 1, userInfo: nil))
            }
            
            let employer = Employer(Name: name, Description: description, LogoUrl: nil)
            
            return .success(employer)
        } catch {
            return .error(error)
        }
    }
    
    
}
