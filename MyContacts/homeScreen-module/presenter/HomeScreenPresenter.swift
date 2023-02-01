//
//  HomeScreenPresenter.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation
import UIKit

class HomeScreenPresenter: ViewToPresenterHomeScreenProtocol {
    var homeScreenInteractor: PresenterToInteractorHomeScreenProtocol?
    
    var homeScreenView: PresenterToViewHomeScreenProtocol?
    
    func loadAllContacts() {
        homeScreenInteractor?.getAllContacts()
    }
    
    func searchContacts(with word: String) {
        homeScreenInteractor?.search(with: word)
    }
    
    func deleteContact(at index: Int) {
        homeScreenInteractor?.delete(at: index)
    }
     
}

extension HomeScreenPresenter: InterActorToPresenterHomeScreenProtocol {
    func sendDataToPresenter(peopleList: [Contacts]) {
        homeScreenView?.sendDataToView(peopleList: peopleList)
        
    }
    
    
}
