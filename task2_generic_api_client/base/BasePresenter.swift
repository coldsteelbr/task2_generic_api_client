//
//  BasePresenter.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 27.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

class BasePresenter<V: BaseViewProtocol> {
    var view: V?
    
    func attach(View view: V, Updating:Bool){
        self.view = view
        if Updating {
            sendNotifications()
        }
    }
    
    func detach(View view: V) {
        self.view = nil
    }
    
    func sendNotifications() {
        fatalError("\(#function) must be implemented")
    }
}
