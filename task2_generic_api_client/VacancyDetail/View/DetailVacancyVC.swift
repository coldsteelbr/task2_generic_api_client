//
//  DetailVacancyVC.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit

class DetailVacancyVC: BaseSceenView {
    //
    //  Field & Properties
    //
    var vacancy: Vacancy?
    var presenter: DetailVacancyPresenter? = FrameworkFactory.presenterForVacancyDetail()
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 0
        return nf
    }()
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        return df
    }()
    
    //
    //  Outlets
    //
    @IBOutlet var emplyersLogo: UIImageView!
    @IBOutlet var vacancyTitle: UILabel!
    @IBOutlet var vacancySalaryLabel: UILabel!
    @IBOutlet var vacancyEmployer: UILabel!
    @IBOutlet var vacancyDate: UILabel!
    @IBOutlet var vacancyDescription: UITextView!
    
    
    
    //
    //  BaseScrenView
    //
    override func update() {
        //fatalError("\(#function) must be implemented")
        //
        //  TODO: SET ACTION
        //
        if let _ = presenter?.isFavorite {
            navigationItem.rightBarButtonItem?.title = "Remove"
        } else {
            navigationItem.rightBarButtonItem?.title = "Add"
        }
    }
    
    //
    //  Lifecycle
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.attachView(self, updating: false)
        presenter?.favoriteStateForVacancy(vacancy!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        populateUI()
    }
    
    /// Sets UI widgets with Vacancy item values
    func populateUI() {
        // - title
        vacancyTitle.text = vacancy?.title
        // - salary
        if let salary = vacancy?.salary {
            vacancySalaryLabel.text = numberFormatter.string(from: salary as NSNumber)
        }
        // - employer
        vacancyEmployer.text = vacancy?.employer.name
        // - date
        if let date = vacancy?.date {
            vacancyDate.text = dateFormatter.string(from: date)
        }
        // - description
        vacancyDescription.text = vacancy?.description
    }
}
