//
//  PersonDetailProtocol.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation

protocol ViewToPresenterDetailProtocol {
    var detailInteractor: PresenterToInteractorDetailProtocol? {get set}
    var detailView: PresenterToViewDetailProtocol? {get set}
    
    func currentPersonInfo(_ contactName: String, _ contactPhone: String)
    func editedPersonInfo(_ conratcName: String, _ contactPhone: String)
}

protocol PresenterToInteractorDetailProtocol {
    
    var detailPresenter: InteractorToPresenterDetailProtocol? {get set}
    
    func edit(_ contactName: String, _ contactPhone: String)
}



protocol InteractorToPresenterDetailProtocol {
    func sendDataToPresenter(currentName: String, currentPhone: String)
}

protocol PresenterToViewDetailProtocol {
    // Presenterdan Viewe veri transferi için gerekli methodlar.
    func sendDataToView(currentName: String, currentPhone: String)
    func sendDataToView(updatedName: String, updatedPhone: String)
}


protocol PresenterToRouteDetailProtocol {
    static func createModule(ref: DetailVC)
}
