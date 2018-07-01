//
//  HhRequest.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 30.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case vacancies = "/vacancies?"
    case employer = "/employers/"
}

class HhRequest: Request {
    let client: HttpClient
    
    let baseUrl = "https://api.hh.ru"
    let userAgent = ("User-Agent", "GenericApiClient/1.0 (mail@example.com)")
    let requestMethod:RequestMethod
    let requestParameters: [String:String]?
    
    //
    //  Logic
    //
    
    init(HttpClient client: HttpClient, RequestMethod method:RequestMethod, Params params: [String:String]) {
        requestMethod = method
        requestParameters = params
        self.client = client
    }
    
    func execute(with completion: @escaping (VacanciesRequestResult) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.client.performHttpForRequest(self.getRequestString()!) {
                (requestResult) in
                
                completion(requestResult)
            }
        }
    }
    
    //
    //  RequestProtocol methods
    //
    func getRequestString() -> String? {
        // building url address for HH API
        var components = URLComponents(string: baseUrl + requestMethod.rawValue)
        var queryItems = [URLQueryItem]()
        
        if let requestParams = requestParameters {
            for (name, value) in requestParams {
                let item = URLQueryItem(name: name, value: value)
                queryItems.append(item)
            }
        }
        
        components?.queryItems = queryItems
        
        return components?.url?.absoluteString
    }
    
}
