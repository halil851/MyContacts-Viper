//
//  NewContactVC.swift
//  MyContacts
//
//  Created by halil dikişli on 19.01.2023.
//

import UIKit

class NewContactVC: UIViewController {
    
    var addPersonPresenterObject: ViewToPresenterAddPersonProtocol?

    
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var contactPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contactName.delegate = self
        contactPhone.delegate = self
        AddPersonRouter.createModule(ref: self)
        
        contactPhone.text = "+90"
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contactName.becomeFirstResponder()
    }
 
    @IBAction func addContact(_ sender: UIButton) {
       
        if let name = contactName.text,
           let phone = contactPhone.text {
                
            addPersonPresenterObject?.add(name, phone)
        }
        navigationController?.popToRootViewController(animated: true)
    }
}


//MARK: - Text Field Editing
extension NewContactVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        contactName.endEditing(true)
        contactPhone.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contactName.endEditing(true)
        contactPhone.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        contactName.endEditing(true)
        contactPhone.endEditing(true)

        return true
    }
    
    
}

//MARK: - For "+XX (XXX) XXX XX XX" Format
extension NewContactVC {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        if contactPhone.isEditing {
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


