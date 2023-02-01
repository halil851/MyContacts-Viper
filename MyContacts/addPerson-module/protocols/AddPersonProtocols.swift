//
//  AddPersonProtocols.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation

// Presenter'a eklenmeli
protocol ViewToPresenterAddPersonProtocol {
    var addPersonInteractor: PresenterToInteractorAddPersonProtocol? {get set}
    func add(_ contactName: String, _ contactPhoneNumber: String)
}


// Interactor'a eklenmeli
protocol PresenterToInteractorAddPersonProtocol {
    func addPerson(_ contactName: String, _ contactPhoneNumber: String)
}

//Router'a eklenmeli
protocol PresenterToRouterAddPersonProtocol {
    static func createModule(ref: NewContactVC)
}
