//
//  AddPersonPresenter.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation

class AddPersonPresenter: ViewToPresenterAddPersonProtocol {
    var addPersonInteractor: PresenterToInteractorAddPersonProtocol?
    
    func add(_ contactName: String, _ contactPhoneNumber: String) {
        addPersonInteractor?.addPerson(contactName, contactPhoneNumber)
    }
    
    
}
