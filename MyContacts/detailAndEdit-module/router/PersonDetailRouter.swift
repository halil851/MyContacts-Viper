//
//  PersonDetailRouter.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation

class PersonDetailRouter: PresenterToRouteDetailProtocol {
    static func createModule(ref: DetailVC) {
        
        let presenter = PersonDetailPresenter()
        
        ref.detailPresenterObject = presenter
        
        ref.detailPresenterObject?.detailInteractor = PersonDetailInteractor()
        ref.detailPresenterObject?.detailView = ref
        
        ref.detailPresenterObject?.detailInteractor?.detailPresenter = presenter
    }
    
    
    
    
}
