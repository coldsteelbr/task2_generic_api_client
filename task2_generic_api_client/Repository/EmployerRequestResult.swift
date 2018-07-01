//
//  EmployerRequestResult.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 02.07.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

enum EmployerRequestResult {
    case success(Employer)
    case error(Error)
}
