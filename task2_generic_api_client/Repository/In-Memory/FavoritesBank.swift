//
//  FavoritesBank.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 29.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class FavoritesBank {
    private var favorites = [Vacancy] ()
    
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
    
}
