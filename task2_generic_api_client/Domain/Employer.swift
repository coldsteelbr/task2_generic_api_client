//
//  Employer.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 26.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class Employer {
    let name: String
    let description: String?
    let logoUrl: String?
    
    init(Name name: String, Description description: String, LogoUrl logoUrl: String?){
        self.name = name
        self.description = description
        self.logoUrl = logoUrl
    }
    
    static func genericEmployer() -> Employer {
        return Employer(Name: "Generic", Description: "Employer", LogoUrl: nil)
    }
    
}
