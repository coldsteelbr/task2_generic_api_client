//
//  VacancyListPresenter.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 27.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class VacancyListPresenter: BasePresenter<VacancyListVC> {
    
    var repository: Repository?
    
    var vacancyArray: [Vacancy]!
    
    
    private func updateViews(){
        view?.update(vacancyArray: vacancyArray)
    }
    
    func searchWith(searchString: String){
        //
        //  Creating a request
        //
        let request = InMemoryRequest(filter: searchString, field: "title")
        
        //
        //  Sending request
        //
        repository!.getVacanciesForRequest(request) {
            (result) in
            DispatchQueue.main.async {
                switch(result) {
                case let .success(resultArray):
                    self.vacancyArray = resultArray
                    self.view?.update(vacancyArray: self.vacancyArray)
                case let .error(error):
                    print("Error: \(error)")
                    self.view?.showErrorAlert(title: "Error", message: error as! String)
                }
            }
            
        }
    }
}
