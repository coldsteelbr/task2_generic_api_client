//
//  DetailVacancyVC.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit

class DetailVacancyVC: BaseSceenView, DetailVacancyViewProtocol {
    
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
    @IBOutlet var vacancyEmployer: UIButton!
    @IBOutlet var vacancyDate: UILabel!
    @IBOutlet var vacancyDescription: UITextView!
    
    
    
    //
    //  BaseScrenView
    //
    override func update() {

        //
        //  TODO: SET ACTION
        //
        if let isf = presenter?.isFavorite {
            
            if isf {
                print("\(#function) is favorite: \(isf)")
                navigationItem.rightBarButtonItem?.title = "Remove"
            } else {
                print("\(#function) is favorite: \(isf)")
                navigationItem.rightBarButtonItem?.title = "Add"
            }
            
        }
    }
    
    //
    //  DetailVacancyViewProtocol
    //
    func updateImageWith(_ result: ImageResult) {
        switch result {
        case let .success(image):
            emplyersLogo.image = image
        case let .failure(error):
            print("No image: \(error)")
        }
    }
    
    //
    //  Lifecycle
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            presenter = FrameworkFactory.presenterForVacancyDetail()
        }
        presenter?.attachView(self, updating: false)
        presenter?.favoriteStateForVacancy(vacancy!)
        if let url = vacancy?.logoUrl {
            presenter?.needImageForUrl(url)
        }
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
        if let salary_from = vacancy?.salary_from {
            vacancySalaryLabel.text = numberFormatter.string(from: salary_from as NSNumber)
        }
        if let salary_to = vacancy?.salary_to {
            vacancySalaryLabel.text = "\(vacancySalaryLabel.text ?? "") - " + numberFormatter.string(from: salary_to as NSNumber)!
        }
        // - employer
        vacancyEmployer.setTitle(vacancy?.employer.name, for: .normal)
        // - date
        if let date = vacancy?.date {
            vacancyDate.text = dateFormatter.string(from: date)
        }
        // - description
        vacancyDescription.text = vacancy?.description
    }
    
    @IBAction func toggleFavorite(_ sender: UIBarButtonItem) {
        presenter?.toggleFavoriteStateForVacancy(vacancy!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showEmployerDetail":
            (segue.destination as! EmployerVC).employer = vacancy?.employer
        default:
            preconditionFailure("No such a segue")
        }
    }
}
