//
//  VacancyListInteractor.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class VacancyListInteractor: BaseInteractor{
    
    func searchWith(searchString: String, with completion: @escaping (VacanciesRequestResult)->Void){
        //
        //  Creating a request
        //
        // in-memory request:
        //let request = InMemoryRequest(filter: searchString, field: "title")
        // Http API
        let dataParser: DataParserProtocol = HhDataParser()
        let client = HttpClient(dataParser: dataParser)
        let params = [ "text" :  searchString,  // text for searching for
                       "area":  "4",            // 4 is for Novosibirsk
                       "search_field":  "name"] // search in vacancy's title
        let request = HhRequest(HttpClient: client, RequestMethod: .vacancies, Params: params)
        
        //
        //  Sending request
        //
        repository!.getVacanciesForRequest(request) {
            (result) in
            
            completion(result)
        }
    }
    
    func getImageForUrl(_ urlString: String, with completion: @escaping (ImageResult)->Void) {
        if let url =  URL(string: urlString) {
            repository!.getImageForUrl(url){
                (result) in
                
                completion(result)
            }
        } else {
            completion(.failure(NSError(domain: "No URL", code: 1, userInfo: nil)))
        }
    }
}
