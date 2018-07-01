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
    
    /// requests searching by given string
    func searchWith(searchString: String){
        view?.businessIndicator(Turn: .On)
        
        (interactor as! VacancyListInteractor).searchWith(searchString: searchString) {
            (result) in
            
            DispatchQueue.main.async {
                switch(result) {
                case let .success(resultArray):
                    self.vacancyArray = resultArray
                    self.notifyView()
                    if(self.vacancyArray?.isEmpty)! {
                        self.view?.showErrorAlert(title: "Empry response", message: "No result on your request")
                    }
                case let .error(error):
                    print("Error: \(error)")
                    self.view?.showErrorAlert(title: "Error", message: error as! String)
                }
                self.view?.businessIndicator(Turn: .Off)
                
            }// main.async
        }// interactor
    } // func
    
    /// requesting image for given url string for table view cells
    func needImageForUrl(_ urlString: String, forRowAt index: IndexPath, and vacancy: Vacancy) {
        (interactor as! VacancyListInteractor).getImageForUrl(urlString) {
            (result) in
            
            OperationQueue.main.addOperation {
                self.view?.updateCellWith(result, forRowAt: index, and: vacancy)
            } // main.async
        } // interactor
    } // func
}
