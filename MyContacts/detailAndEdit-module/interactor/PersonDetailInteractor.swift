//
//  PersonDetailInteractor.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation

class PersonDetailInteractor: PresenterToInteractorDetailProtocol {
    
    var detailPresenter: InteractorToPresenterDetailProtocol?
    
    func edit(_ contactName: String, _ contactPhone: String) {
        detailPresenter?.sendDataToPresenter(currentName: contactName.capitalized, currentPhone: contactPhone)
    }
    
    
}
