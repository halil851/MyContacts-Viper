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
           contactName.text != "",
           let phone = contactPhone.text {

            addPersonPresenterObject?.add(name, phone)
            navigationController?.popToRootViewController(animated: true)
            
        } else {
            let alert = UIAlertController(title: "Please type a name!", message: "Name field can not be empty!", preferredStyle: .alert)
            let done = UIAlertAction(title: "Done", style: .default) { action in
                //When the User click the "Done"
            }
            alert.addAction(done)
            present(alert, animated: true)
            
        }
        
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




