//
//  PersonDetailInteractor.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation

class PersonDetailInteractor: PresenterToInteractorDetailProtocol {
    func edit(_ contactName: String, _ contactPhone: String) {
        print(contactName, contactPhone)
    }
    
    
}
