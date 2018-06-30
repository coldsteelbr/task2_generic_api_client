//
//  HttpClient.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 30.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class HttpClient {
    let dataParser: DataParserProtocol
    
    init(dataParser: DataParserProtocol) {
        self.dataParser = dataParser
    }
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    public func performHttpForRequest(_ request: String, completion: @escaping (RequestResult) -> Void){
        let url = URL.init(string: request)
        
        let urlRequest = URLRequest(url: url!)
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) -> Void in
            
            var result = RequestResult.success([])
            if let jsonData = data {
                //do {
                var vacancyList = [Vacancy]()
                
                
                //vacancyList =
                result = self.dataParser.fetchVacancyListFrom(JSON: jsonData)
                switch(result){
                case let .success(vacancies):
                    vacancyList = vacancies
                case let .error(error):
                    print("Error while fetching vacancies: \(error)")
                }
                
                
                print(vacancyList)
                
            } else if let requestError = error {
                print("Error getting vacancies: \(requestError)")
            } else {
                print("Unexpected error")
            }
            
            completion(result)
        }
        task.resume()
    }
}
