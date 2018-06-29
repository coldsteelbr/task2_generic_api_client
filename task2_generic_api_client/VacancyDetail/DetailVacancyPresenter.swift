//
//  DetailVacancyPresenter.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation


class DetailVacancyPresenter: BasePresenter<DetailVacancyVC> {
    
    // TODO: trying to add to favorites
    // TODO: trying to remove from favorites
    
    var isFavorite: Bool?
    
    //
    //  Base presenter
    //
    
    override func update() {
        print("\(#function) TBD")
    }
    
    //
    //  Logic
    //
    
    func favoriteStateForVacancy(_ vacancy: Vacancy) {
        (interactor as! DetailVacancyInteractor).checkForFavorite(vacancy: vacancy) {
            (isVacancyFavorite) in
            DispatchQueue.main.async {
                self.view?.update()
            }
        }
    }
}
