//
//  EmployerPresenter.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class EmployerPresenter: BasePresenter<EmployerVC> {
    /// requesting image for given url string for table view cells
    func needImageForUrl(_ urlString: String) {
        (interactor as! EmployerInteractor).getImageForUrl(urlString) {
            (result) in
            
            DispatchQueue.main.async {
                (self.view! as EmployerViewProtocol).updateImageWith(result)
                
            } // main.async
        } // interactor
    } // func
}
