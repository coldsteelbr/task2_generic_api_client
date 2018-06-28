//
//  BaseViewProtocol.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 27.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

protocol BaseViewProtocol: Equatable {
    func update()
    func showErrorAlert(title:String, message:String)
}
