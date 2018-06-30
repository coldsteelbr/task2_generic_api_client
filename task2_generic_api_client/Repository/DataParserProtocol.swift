//
//  DataParserProtocol.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 30.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

protocol DataParserProtocol {
    func fetchVacancyListFrom(JSON json: Data) -> RequestResult
}
