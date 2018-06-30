//
//  FavoritesPresenter.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class FavoritesPresenter: BasePresenter<FavoritesVC> {
    var favorites: [Vacancy]?
    
    func getAllFavorites() {
        (interactor as! FavoritesInteractor).getAllFavorites() {
            (result) in
            self.favorites = result
            DispatchQueue.main.async {
                self.view?.update()
            }
        }
    }
}
