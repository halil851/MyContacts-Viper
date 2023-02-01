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
        
        homeScreenPresenter?.sendDataToPresenter(peopleList: allContactsVIPER)
        
        appDelegate.saveContext()
    }
    
    func search(with word: String) {

        let fetchRequest: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "contactName CONTAINS[c] %@", word)
        let sort = NSSortDescriptor(key: "contactName", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            allContactsVIPER = try context.fetch(fetchRequest)
        } catch {
            print("An error occur while search() method working \(error) ")
        }
        homeScreenPresenter?.sendDataToPresenter(peopleList: allContactsVIPER)
    }
    
    func delete(at index: Int) {
        print("VIPER, Silmek istenen kişi indexPath.row: \(index)")
        
        let deletePerson = self.allContactsVIPER[index]
        self.context.delete(deletePerson)
        
        appDelegate.saveContext()
    }
    
    
}
