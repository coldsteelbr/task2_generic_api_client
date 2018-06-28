//
//  BaseView.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit

class BaseSceenView: UIViewController, BaseViewProtocol {
    func update() {
        fatalError("\(#function) must be implemented")
    }
    
    /// Shows an alert with "Okay" button, title and message
    func showErrorAlert(title:String, message:String) {
        // building and showing an alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
