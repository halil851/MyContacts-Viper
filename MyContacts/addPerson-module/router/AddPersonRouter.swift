//
//  AddPersonRouter.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation

class AddPersonRouter: PresenterToRouterAddPersonProtocol {
    static func createModule(ref: NewContactVC) {
        ref.addPersonPresenterObject = AddPersonPresenter()
        ref.addPersonPresenterObject?.addPersonInteractor = AddPersonInteractor()
    }
    
    
}
