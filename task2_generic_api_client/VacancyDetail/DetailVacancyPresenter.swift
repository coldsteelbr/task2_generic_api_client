//
//  DetailVacancyPresenter.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation


class DetailVacancyPresenter: BasePresenter<DetailVacancyVC> {
    
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
    
    /// Check out if a vacancy is in favorites
    func favoriteStateForVacancy(_ vacancy: Vacancy) {
        (interactor as! DetailVacancyInteractor).checkForFavorite(vacancy: vacancy) {
            (isVacancyFavorite) in

            self.isFavorite = isVacancyFavorite
            DispatchQueue.main.async {
                self.view?.update()
            }
        }
    }
    
    /// Toggle vacancy's favorite state
    func toggleFavoriteStateForVacancy(_ vacancy: Vacancy) {
        (interactor as! DetailVacancyInteractor).toggleFavoriteStateForVacancy(vacancy) {
            (isVacancyFavorite) in

            self.isFavorite = isVacancyFavorite
            DispatchQueue.main.async {
                self.view?.update()
            }
        }
    }
    
    /// requesting image for given url string for table view cells
    func needImageForUrl(_ urlString: String) {
        (interactor as! DetailVacancyInteractor).getImageForUrl(urlString) {
            (result) in
            
            DispatchQueue.main.async {
                (self.view! as DetailVacancyViewProtocol).updateImageWith(result)
                
            } // main.async
        } // interactor
    } // func
}
