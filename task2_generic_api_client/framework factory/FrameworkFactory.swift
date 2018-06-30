//
//  FrameworkFactory.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 29.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class FrameworkFactory {
    private static var detailVacancyPresenter: DetailVacancyPresenter?
    private static var employerPresenter: EmployerPresenter?
    private static var favoritesPresenter: FavoritesPresenter?
    
    static func presenterForVacancyDetail() -> DetailVacancyPresenter {
        
        if detailVacancyPresenter == nil{
            let interactor = DetailVacancyInteractor(repository: Repository.getInstance())
            detailVacancyPresenter = DetailVacancyPresenter(interactor: interactor)
        }
        return detailVacancyPresenter!
    }
    
    
    static func presenterForEmployer() -> EmployerPresenter {
        if employerPresenter == nil {
            let interactor = EmployerInteractor(repository: Repository.getInstance())
            employerPresenter = EmployerPresenter(interactor: interactor)
        }
        return employerPresenter!
    }
    
    static func presenterForFavorites() -> FavoritesPresenter {
        if favoritesPresenter == nil {
            let interactor = FavoritesInteractor(repository: Repository.getInstance())
            favoritesPresenter = FavoritesPresenter(interactor: interactor)
        }
        return favoritesPresenter!
    }
}
