//
//  VacancyListViewProtocol.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 27.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

enum IndicatorStates{
    case On
    case Off
}

protocol VacancyListViewProtocol: BaseViewProtocol {
    var vacancyArray: [Vacancy] {get set}
    var searchText: String {get}
    
    //
    //  View Commands
    //
    
    func showVacancyDetailFor(vacancy: Vacancy)
    
    /// Turns on and off business indicator (like spinner)
    func businessIndicator(Turn state: IndicatorStates)
    
    
    //
    // Observer
    //
    func update()
}
