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

    var homeScreenPresenterObject: ViewToPresenterHomeScreenProtocol?

    @IBOutlet weak var contactCounter: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var contactsTV: UITableView!
    
    var allContacts = [Contacts]() //
    
    var isContactEditing = false
    var isSearching = false
    var searchingWord = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        contactsTV.delegate = self
        contactsTV.dataSource = self
        
        HomeScreenRouter.createModule(ref: self)
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateList()
    }
}
//MARK: - Presenter To ViewHomeScreenProto
extension ViewController: PresenterToViewHomeScreenProtocol {
    func sendDataToView(peopleList: [Contacts]) {
        
        allContacts = peopleList
        contactCounter.text = "\(allContacts.count) Contacts"
        contactsTV.reloadData()
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
 
    func updateList() {
        if isSearching {
            homeScreenPresenterObject?.searchContacts(with: searchingWord)
        } else {
            homeScreenPresenterObject?.loadAllContacts()
        }
    }
    
    func delete(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, _  in
            
            guard let person = self.allContacts[indexPath.row].contactName else {return}
            
            let alert = UIAlertController(title: "Are you sure to DELETE \(person)?", message: "", preferredStyle: .alert)
            
            let delete = UIAlertAction(title: "DELETE", style: .destructive) { action in
                //When the User click the "DELETE"
                self.homeScreenPresenterObject?.deleteContact(at: indexPath.row)
                self.updateList()
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .default) { action in
                //When the User click the "Cancel"
                self.updateList()
            }
            
            alert.addAction(delete)
            alert.addAction(cancel)
            
            self.present(alert, animated: true)
            
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchingWord = searchText
        
        if searchText.count == 0 {
            isSearching = false
            homeScreenPresenterObject?.loadAllContacts()
        } else {
            isSearching = true
            homeScreenPresenterObject?.searchContacts(with: searchText)
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
