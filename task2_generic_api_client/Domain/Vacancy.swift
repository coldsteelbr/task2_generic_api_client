//
//  Vacancy.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 26.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

let titles = ["iOS dev", "Android Developer", "Sales manager", "Driver", "Teacher"]
let descriptions = ["A very good person", "Nice professional", "Skilled specialist able to do that job\nas good as it possible"]
let dates = [Date(timeIntervalSince1970: TimeInterval(1530003931)),
             Date(timeIntervalSince1970: TimeInterval(-523929600)),
             Date(timeIntervalSince1970: TimeInterval(547948800)),
]

class Vacancy {
    let title: String
    let description: String?
    let date: Date
    let salary: Decimal?
    let employer: Employer
    let experience: String?
    
    /// Vacancy's logo is employer's logo
    var logoUrl: String? {
        get {
            return employer.logoUrl
        }
    }
    
    /// Inits all the fields
    init(title: String, description: String, date: Date, salary: Decimal, employer: Employer, experience: String) {
        self.title = title
        self.description = description
        self.date = date
        self.salary = salary
        self.employer = employer
        self.experience = experience
    }
    
    /// Creates a random Vacancy
    convenience init (random: Bool){
        // random?
        if random {
            // creating a random vacancy out of hardcoded arrrays
            var randomIndex: Int
            
            randomIndex = Utils.randFromZeroTo(titles.count)
            let randomTitle = titles[randomIndex]
            
            randomIndex = Utils.randFromZeroTo(descriptions.count)
            let randomDescription = descriptions[randomIndex]
            
            randomIndex = Utils.randFromZeroTo(dates.count)
            let randomDate = dates[randomIndex]
            
            let randomSalary = Utils.randFromZeroTo(100000)
            
            self.init(title: randomTitle, description: randomDescription, date: randomDate, salary: Decimal(randomSalary), employer: Employer.genericEmployer(), experience: "No experience")
        }
        else {
            // creating an empty vacancy
            self.init(title: "<No title>", description: "<Empty description>", date: Date(), salary: Decimal(0), employer: Employer.genericEmployer(), experience: "")
        }
    }
}
