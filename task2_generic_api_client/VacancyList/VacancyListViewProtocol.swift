//
//  VacancyListViewProtocol.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 27.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

protocol VacancyListViewProtocol: BaseViewProtocol {
    var vacancyArray: [Vacancy] {get set}
    var searchText: String {get}
    
    var hasConnection: Bool {get}
    var isBusy: Bool {get}
    
    //
    //  View Commands
    //
    
    func showVacancyDetailFor(vacancy: Vacancy)
    
    //
    // Observer
    //
    func update(vacancyArray:[Vacancy])
}
