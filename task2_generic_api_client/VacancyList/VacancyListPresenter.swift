//
//  VacancyListPresenter.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 27.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation
import UIKit // TODO: REMOVE WHEN TESTED

class VacancyListPresenter: BasePresenter<VacancyListVC> {
    
    var vacancyArray: [Vacancy]?
    
    init(interactor: VacancyListInteractor){
        super.init(interactor: interactor)
    }
    
    
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
            }
            
        }
    }
    
    //
    //  Rewrite or DELETE
    //
    var tempImage: UIImage?
    
    func needImageForUrl(_ urlString: String) {
        (interactor as! VacancyListInteractor).getImageForUrl(urlString) {
            (result) in
            DispatchQueue.main.async {
                switch result {
                case let .success(image):
                    self.tempImage = image
                    self.view?.update()
                case let .failure(error):
                    print("Error downloading image: \(error)")
                }
            }
        }
    }
}
