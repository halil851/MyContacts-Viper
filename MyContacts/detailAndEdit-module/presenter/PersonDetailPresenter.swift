//
//  PersonDetailPresenter.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation

class PersonDetailPresenter: ViewToPresenterDetailProtocol {
    
    
    
    
    var detailView: PresenterToViewDetailProtocol?
    
    var detailInteractor: PresenterToInteractorDetailProtocol?
    
    func currentPersonInfo(_ contactName: String, _ contactPhone: String) {
        detailInteractor?.edit(contactName, contactPhone)
    }
    func editedPersonInfo(_ conratcName: String, _ contactPhone: String) {
        detailInteractor?.edit(conratcName, contactPhone)
    }

    
}

extension PersonDetailPresenter: InteractorToPresenterDetailProtocol {
    func sendDataToPresenter(currentName: String, currentPhone: String) {
        detailView?.sendDataToView(currentName: currentName, currentPhone: currentPhone)
        detailView?.sendDataToView(updatedName: currentName, updatedPhone: currentPhone)
    }
    
    
    
    
}
