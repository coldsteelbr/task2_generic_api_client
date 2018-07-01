//
//  RequestResult.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 26.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

enum  VacanciesRequestResult {
    case success([Vacancy])
    case error(Error)
}
