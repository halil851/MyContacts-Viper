//
//  ViewController.swift
//  MyContacts
//
//  Created by halil dikişli on 18.01.2023.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var searchBar: UISearchBar!  
    @IBOutlet weak var contactsTV: UITableView!
    
    var allContacts = [Contacts]()
    
    var isContactEditing = false
    var isSearching = false
    var searchingWord = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        contactsTV.delegate = self
        contactsTV.dataSource = self
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateList()
    }
   
    
}

// MARK: - Table View Delegate

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactCellTVC
        
        cell.contactName.text = allContacts[indexPath.row].contactName
        cell.contactNumber.text = allContacts[indexPath.row].contactPhoneNumber
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toDetailScreen", sender: indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = self.delete(at:indexPath)
        let update = self.edit(at:indexPath)
        
        let swipe = UISwipeActionsConfiguration(actions: [delete, update])
        
        return swipe
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as? Int
        
        
        if segue.identifier == "toDetailScreen",
           let index = indexPath {
            
            let destination = segue.destination as! DetailVC
            
            if isContactEditing {
                destination.isContactEditing = true
                isContactEditing = false
            }
            
            destination.person = allContacts[index]
        }
    }
    
    //MARK: - Data Manipulation
    
    func getAllContacts() {
        
        let fetchRequest: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        let sort = NSSortDescriptor(key: "contactName", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            allContacts = try context.fetch(fetchRequest)
            contactsTV.reloadData()
        } catch {
            print("An error occur while getAllContacts() method working \(error) ")
        }
    }
    
    func updateList() {
        if isSearching {
            search(with: searchingWord)
        } else {
            getAllContacts()
        }
    }
    
    func delete(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, _  in
            
            let deletePerson = self.allContacts[indexPath.row]
            self.context.delete(deletePerson)
            appDelegate.saveContext()
            
            self.updateList()
        }
        
        return action
    }
    
    func edit(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { _, _, _  in
            
            self.isContactEditing = true
            self.performSegue(withIdentifier: "toDetailScreen", sender: indexPath.row)
            
        }
        
        return action
    }
    
    
}

// MARK: - SearhField Delegate

extension ViewController: UISearchBarDelegate {
    
    func search(with contactName: String) {
        
        let fetchRequest: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "contactName CONTAINS[c] %@", contactName)
        let sort = NSSortDescriptor(key: "contactName", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            allContacts = try context.fetch(fetchRequest)
            contactsTV.reloadData()
        } catch {
            print("An error occur while search() method working \(error) ")
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        searchingWord = searchText
        
        if searchText.count == 0 {
            isSearching = false
            getAllContacts()
        } else {
            isSearching = true
            search(with: searchingWord)
        }
        
        contactsTV.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

// MARK: - Dismiss Keyboard

extension ViewController {
    @objc func dismissKeyboard() {
           view.endEditing(true)
       }
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
