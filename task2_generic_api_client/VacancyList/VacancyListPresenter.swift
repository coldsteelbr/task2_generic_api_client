//
//  VacancyListPresenter.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 27.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class VacancyListPresenter: BasePresenter<VacancyListVC> {
    
    var vacancyArray: [Vacancy]?
    
    init(interactor: VacancyListInteractor){
        super.init(interactor: interactor)
    }
    
    override func notifyView() {
        view?.update()
    }
    
    func searchWith(searchString: String){
        
        (interactor as! VacancyListInteractor).searchWith(searchString: searchString) {
            (result) in
            DispatchQueue.main.async {
                switch(result) {
                case let .success(resultArray):
                    self.vacancyArray = resultArray
                    self.notifyView()
                case let .error(error):
                    print("Error: \(error)")
                    self.view?.showErrorAlert(title: "Error", message: error as! String)
                }
                
            }
            
        }
    }
}
