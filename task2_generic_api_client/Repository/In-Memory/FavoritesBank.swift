//
//  FavoritesBank.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 29.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

/// Represent an in-memory storage of favorite vacancies. Singleton
class FavoritesBank {
    private var favorites = [String:Vacancy] ()
    
    //
    // Singleton
    //
    
    static var instance: FavoritesBank?
    static func getInstance() ->FavoritesBank {
        if instance == nil {
            instance = FavoritesBank()
        }
        return instance!
    }
    
    private init() {}
    
    //
    // Logic
    //
    
    func addVacancy(_ vacancy: Vacancy) {
        favorites[vacancy.url] = vacancy
    }
    
    func removeVacancy(_ vacancy: Vacancy) {
        favorites.removeValue(forKey: vacancy.url)
    }
    
    func contains(_ vacancy: Vacancy) -> Bool {
        return favorites[vacancy.url] != nil
    }
    
    func getAllVacancies() -> [Vacancy] {
        return Array(favorites.values)
    }
}
