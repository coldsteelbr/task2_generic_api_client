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
    let interactor: BaseInteractor?
    
    init(interactor: BaseInteractor) {
        self.interactor = interactor
    }
    
    func attachView(_ view: V, updating:Bool){
        self.view = view
        
        if updating {
            notifyView()
        }
    }
    
    func detachView(_ view: V?) {
        if self.view == view {
            self.view = nil
        }
    }
    
    func notifyView() {
        view?.update()
    }
    
    func update(){
        fatalError("\(#function) must be implemented")
    }
}
