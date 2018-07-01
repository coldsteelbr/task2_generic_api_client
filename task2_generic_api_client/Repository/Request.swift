//
//  Request.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 26.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

protocol Request {
    func execute(with completion: @escaping (VacanciesRequestResult) -> Void)
}
