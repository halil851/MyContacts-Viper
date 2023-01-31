//
//  DetailVC.swift
//  MyContacts
//
//  Created by halil dikişli on 19.01.2023.
//

import UIKit

class DetailVC: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactPhone: UILabel!
    
    @IBOutlet weak var updateName: UITextField!
    @IBOutlet weak var updatePhone: UITextField!
    
    var person: Contacts?
    
    var isContactEditing = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
//        updateName.leftView = paddingView
//        updateName.leftViewMode = .always
        
        let edit = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButton))
        navigationItem.rightBarButtonItem = edit

        if let personSafe = person {
            contactName.text = personSafe.contactName
            contactPhone.text = personSafe.contactPhoneNumber
        }
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        if isContactEditing {
            updateName.becomeFirstResponder()
        }
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        if isContactEditing {
            startEditing()
        }
        
    }
    
    @objc func updateTapped() {
        
        let edit = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButton))
        navigationItem.rightBarButtonItem = edit
        
        contactName.text = updateName.text?.capitalized
        contactPhone.text = updatePhone.text
        
        person?.contactName = updateName.text?.capitalized
        person?.contactPhoneNumber = updatePhone.text
        
        updateName.endEditing(true)
        updatePhone.endEditing(true)
        
        editOrUpdate()
        appDelegate.saveContext()
    }
    
    

    @IBAction func editButton(_ sender: UIBarButtonItem) {
        startEditing()
        updateName.becomeFirstResponder()
       
    }
    
    func editOrUpdate() {
        updateName.isHidden = !updateName.isHidden
        updatePhone.isHidden = !updatePhone.isHidden
        contactName.isHidden = !contactName.isHidden
        contactPhone.isHidden = !contactPhone.isHidden
    }
    
    func startEditing() {
        let update = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(updateTapped))
        
        updateName.text = contactName.text?.capitalized
        updatePhone.text = contactPhone.text
        
        person?.contactName = contactName.text?.capitalized
        person?.contactPhoneNumber = contactPhone.text
        
        editOrUpdate()
        
        if !isContactEditing {
            updateName.becomeFirstResponder()
        }
        
        navigationItem.rightBarButtonItem = update
        appDelegate.saveContext()
    }
}
