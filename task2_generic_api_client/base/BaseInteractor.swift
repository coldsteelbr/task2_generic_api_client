//
//  BaseInteractor.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class BaseInteractor {
    var repository: Repository?
    
    init(repository: Repository) {
        self.repository = repository
    }
}
