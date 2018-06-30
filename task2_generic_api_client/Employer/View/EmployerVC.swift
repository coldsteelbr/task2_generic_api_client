//
//  EmployerVC.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit

class EmployerVC: BaseSceenView {
    var employer: Employer?
    
    @IBOutlet var employerName: UILabel!
    @IBOutlet var employerDescription: UITextView!
    @IBOutlet var employerLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populate()
        if let navItem = tabBarController?.navigationItem {
            navItem.title = "Employer"
        }
    }
    
    func populate() {
        employerName.text = employer?.name
        employerDescription.text = employer?.description
    }
    
}

