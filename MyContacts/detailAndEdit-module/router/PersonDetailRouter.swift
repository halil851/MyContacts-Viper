//
//  PersonDetailRouter.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation

class PersonDetailRouter: PresenterToRouteDetailProtocol {
    static func createModule(ref: DetailVC) {
        ref.detailPresenterObject = PersonDetailPresenter()
        ref.detailPresenterObject?.detailInteractor = PersonDetailInteractor()
    }
    
    
    
    
}
