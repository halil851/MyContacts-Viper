//
//  HomeScreenRouter.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation

class HomeScreenRouter: PresenterToRouterHomeScreenProtocol {
    static func createModule(ref: ViewController) {
        
        let presenter = HomeScreenPresenter()
        
        ref.homeScreenPresenterObject = presenter
        
        ref.homeScreenPresenterObject?.homeScreenInteractor = HomeScreenInteractor()
        ref.homeScreenPresenterObject?.homeScreenView = ref
        
        ref.homeScreenPresenterObject?.homeScreenInteractor?.homeScreenPresenter = presenter
    }
    
    
}
