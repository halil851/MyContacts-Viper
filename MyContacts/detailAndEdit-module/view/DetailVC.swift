//
//  DetailVC.swift
//  MyContacts
//
//  Created by halil dikişli on 19.01.2023.
//

import UIKit

class DetailVC: UIViewController, UITextFieldDelegate {
    
    var detailPresenterObject: ViewToPresenterDetailProtocol?

    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactPhone: UILabel!
    
    @IBOutlet weak var updateName: UITextField!
    @IBOutlet weak var updatePhone: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    var person: Contacts?
    
    var isContactEditing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edit = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButton))
        navigationItem.rightBarButtonItem = edit
        
        guard let personSafe = person else {return}
        contactName.text = personSafe.contactName
        contactPhone.text = personSafe.contactPhoneNumber
        
        cancelButton.underline()
        
        updatePhone.delegate = self
        
        PersonDetailRouter.createModule(ref: self)
       
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

    @IBAction func cancelButtonTapped(_ sender: Any) {
        editOrUpdate()
        updateName.endEditing(true)
        updatePhone.endEditing(true)
        let edit = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButton))
        navigationItem.rightBarButtonItem = edit
    }
    @IBAction func updateButtonTapped(_ sender: Any) {
        updateTapped()
    }
}

extension DetailVC {
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        startEditing()
        updateName.becomeFirstResponder()
       
    }
    
    func editOrUpdate() {
        updateName.isHidden = !updateName.isHidden
        updatePhone.isHidden = !updatePhone.isHidden
        contactName.isHidden = !contactName.isHidden
        contactPhone.isHidden = !contactPhone.isHidden
        cancelButton.isHidden = !cancelButton.isHidden
        updateButton.isHidden = !updateButton.isHidden
    }
    
    func startEditing() {
        let update = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(updateTapped))
        guard let currentNameSafe = contactName.text,
              let currentPhoneSafe = contactPhone.text else {return}
        
        detailPresenterObject?.currentPersonInfo(currentNameSafe, currentPhoneSafe)
        
        editOrUpdate()
        
        if !isContactEditing {
            updateName.becomeFirstResponder()
        }
        
        navigationItem.rightBarButtonItem = update
    }
    
    @objc func updateTapped() {
        
        let edit = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButton))
        navigationItem.rightBarButtonItem = edit
        
        guard let updatedNameSafe = updateName.text,
              let updatedPhoneSafe = updatePhone.text else {return}
        
        detailPresenterObject?.editedPersonInfo(updatedNameSafe, updatedPhoneSafe)
        
        updateName.endEditing(true)
        updatePhone.endEditing(true)
        
        editOrUpdate()
    }
}

extension DetailVC: PresenterToViewDetailProtocol {
    func sendDataToView(currentName: String, currentPhone: String) {
        updateName.text = currentName
        updatePhone.text = currentPhone
        person?.contactName = currentName
        person?.contactPhoneNumber = currentPhone
    }
    func sendDataToView(updatedName: String, updatedPhone: String) {
        contactName.text = updatedName
        contactPhone.text = updatedPhone
        person?.contactName = updatedName
        person?.contactPhoneNumber = updatedPhone
    }
    
}



