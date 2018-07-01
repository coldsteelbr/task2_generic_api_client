//
//  File.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit

protocol FavoritesViewProtocol {
    func updateCellWith(_ result: ImageResult, forRowAt index: IndexPath, and vacancy: Vacancy)
}
