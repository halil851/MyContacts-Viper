//
//  HomeScreenProtocols.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation

//MARK: - Main Protocols
protocol ViewToPresenterHomeScreenProtocol {
    // Nereye veri gönderilecekse onun tipinde protocol tanımlanır.
    var homeScreenInteractor: PresenterToInteractorHomeScreenProtocol? {get set}
    var homeScreenView: PresenterToViewHomeScreenProtocol? {get set}
    
    // Presenterda çalışacak methodlar yazılır.
    func loadAllContacts()
    func searchContacts(with word: String)
    func deleteContact(at index: Int)
}

protocol PresenterToInteractorHomeScreenProtocol {
    // Nereye veri gönderilecekse onun tipinde protocol tanımlanır.
    var homeScreenPresenter: InterActorToPresenterHomeScreenProtocol? {get set}
    
    // Interactorda çalışacak methodlar yazılır.
    func getAllContacts()
    func search(with word: String)
    func delete(at index: Int)
}

//MARK: - Carrier Protocols
protocol InterActorToPresenterHomeScreenProtocol {
    // Interactordan Presentera veri transferi için gerekli methodlar.
    func sendDataToPresenter(peopleList: [Contacts])
    
}

protocol PresenterToViewHomeScreenProtocol {
    // Presenterdan Viewe veri transferi için gerekli methodlar.
    func sendDataToView(peopleList: [Contacts])
}

// Yetkilendirme ve bağlantıların yapılacağı yer.
protocol PresenterToRouterHomeScreenProtocol {
    static func createModule(ref: ViewController)
}
