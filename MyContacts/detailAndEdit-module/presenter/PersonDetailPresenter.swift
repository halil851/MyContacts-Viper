//
//  PersonDetailPresenter.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation

class PersonDetailPresenter: ViewToPresenterDetailProtocol {
    var detailInteractor: PresenterToInteractorDetailProtocol?
    
    func editPerson(_ contactName: String, _ contactPhone: String) {
        detailInteractor?.edit(contactName, contactPhone)
    }
    
    
}
