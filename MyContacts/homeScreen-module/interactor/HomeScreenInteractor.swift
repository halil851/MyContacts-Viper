//
//  HomeScreenInteractor.swift
//  MyContacts
//
//  Created by halil dikişli on 31.01.2023.
//

import Foundation
import CoreData

class HomeScreenInteractor: PresenterToInteractorHomeScreenProtocol {
    
    var homeScreenPresenter: InterActorToPresenterHomeScreenProtocol?
    
    let context = appDelegate.persistentContainer.viewContext
    var allContactsVIPER = [Contacts]()
    
    func getAllContacts() {
        let fetchRequest: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        let sort = NSSortDescriptor(key: "contactName", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            allContactsVIPER = try context.fetch(fetchRequest)
        } catch {
            print("An error occur while getAllContacts() method working \(error) ")
        }
        
        print("allContactsVIPER içinde \(allContactsVIPER.count) adet kayıt var")
        print("VIPER ile getAllContact methodu çalıştı.")
        homeScreenPresenter?.sendDataToPresenter(peopleList: allContactsVIPER) /// Gerek olmayabilir.
        
        appDelegate.saveContext()
    }
    
    func search(with word: String) {
        print("VIPER, Aranan kelime: \(word)")
    }
    
    func delete(at index: Int) {
        print("VIPER, Silmek istenen kişi indexPath.row: \(index)")
    }
    
    
}
