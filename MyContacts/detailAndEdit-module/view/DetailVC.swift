//
//  DetailVC.swift
//  MyContacts
//
//  Created by halil dikişli on 19.01.2023.
//

import UIKit

class DetailVC: UIViewController {
    
    var detailPresenterObject: ViewToPresenterDetailProtocol?

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
        
        guard let personSafe = person else {return}
        contactName.text = personSafe.contactName
        contactPhone.text = personSafe.contactPhoneNumber

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

//MARK: - For "+XX (XXX) XXX XX XX" Format
extension DetailVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        if updatePhone.isEditing {
            textField.text = format(with: "+XX (XXX) XXX XX XX", phone: newString)
        } else {
            return true
        }
        
        return false
    }
    
    /// mask example: `+X (XXX) XXX-XXXX`
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}


