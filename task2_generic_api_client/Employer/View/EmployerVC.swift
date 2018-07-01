//
//  EmployerVC.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit

class EmployerVC: BaseSceenView, EmployerViewProtocol {

    var presenter: EmployerPresenter?
    //
    // Data
    //
    var employer: Employer?
    
    //
    // Outlets
    //
    @IBOutlet var employerName: UILabel!
    @IBOutlet var employerDescription: UITextView!
    @IBOutlet var employerLogo: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        presenter = FrameworkFactory.presenterForEmployer()
        presenter?.attachView(self, updating: false)
    }
    
    //
    // EmployerViewProtocol
    //
    func updateImageWith(_ result: ImageResult) {
        switch result {
        case let .success(image):
            employerLogo.image = image
        case let .failure(error):
            print("No image: \(error)")
        }
    }
    
    //
    // Life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populate()
        if let navItem = tabBarController?.navigationItem {
            navItem.title = "Employer"
        }
        
        if let url = employer?.logoUrl {
            presenter?.needImageForUrl(url)
        }
    }
    
    //
    //  Logic
    //
    func populate() {
        employerName.text = employer?.name
        employerDescription.text = employer?.description
    }
    
}

