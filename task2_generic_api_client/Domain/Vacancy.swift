//
//  Vacancy.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 26.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation
//
//  Placeholding data for in-memory tests
//
let titles = ["iOS dev", "Android Developer", "Sales manager", "Driver", "Teacher"]
let descriptions = ["A very good person", "Nice professional", "Skilled specialist able to do that job\nas good as it possible"]
let dates = [Date(timeIntervalSince1970: TimeInterval(1530003931)),
             Date(timeIntervalSince1970: TimeInterval(-523929600)),
             Date(timeIntervalSince1970: TimeInterval(547948800)),
]
/// Represent a vacancy
class Vacancy: Equatable {
    //
    //  Equatable
    //
    static func == (lhs: Vacancy, rhs: Vacancy) -> Bool {
        return lhs.url == rhs.url
    }
    
    //
    // Vacancy
    //
    let title: String
    let description: String?
    let date: Date
    let salary_from: Decimal?
    let salary_to: Decimal?
    let employer: Employer
    let experience: String?
    let url: String
    
    /// Vacancy's logo is employer's logo
    var logoUrl: String? {
        get {
            return employer.logoUrl
        }
    }
    
    /// Inits all the fields
    init(title: String, description: String, date: Date, salary_from: Decimal?, salary_to: Decimal?, employer: Employer, experience: String, url: String) {
        self.title = title
        self.description = description
        self.date = date
        self.salary_from = salary_from
        self.salary_to = salary_to
        self.employer = employer
        self.experience = experience
        self.url = url
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
            
            let randomUrl = "http://in-memory/\(Utils.randFromZeroTo(100000))"
            
            self.init(title: randomTitle, description: randomDescription, date: randomDate, salary_from: Decimal(randomSalary), salary_to: Decimal(randomSalary), employer: Employer.genericEmployer(), experience: "No experience", url: randomUrl)
        }
        else {
            // creating an empty vacancy
            self.init(title: "<No title>", description: "<Empty description>", date: Date(), salary_from: Decimal(0), salary_to: Decimal(1000), employer: Employer.genericEmployer(), experience: "", url: "")
        }
    }
}
