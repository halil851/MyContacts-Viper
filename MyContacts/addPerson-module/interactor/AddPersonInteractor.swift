//
//  AddPersonInteractor.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation

let context = appDelegate.persistentContainer.viewContext

class AddPersonInteractor: PresenterToInteractorAddPersonProtocol {
    
    func addPerson(_ contactName: String, _ contactPhoneNumber: String) {
        let person = Contacts(context: context)
        person.contactName = contactName.capitalized
        person.contactPhoneNumber = contactPhoneNumber
        
        appDelegate.saveContext()
    }
    
    
}
