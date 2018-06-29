//
//  FrameworkFactory.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 29.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class FrameworkFactory {
    
    static func presenterForVacancyDetail() -> DetailVacancyPresenter {
        let interactor = DetailVacancyInteractor(repository: Repository.getInstance())
        let presenter = DetailVacancyPresenter(interactor: interactor)
        
        return presenter
    }
    
    
    static func presenterForEmployer() -> EmployerPresenter {
        let interactor = EmployerInteractor(repository: Repository.getInstance())
        let presenter = EmployerPresenter(interactor: interactor)
        
        return presenter
    }
    
    static func presenterForFavorites() -> FavoritesPresenter {
        let interactor = FavoritesInteractor(repository: Repository.getInstance())
        let presenter = FavoritesPresenter(interactor: interactor)
        
        return presenter
    }
}
