//
//  ContactDetailViewController.swift
//  Contacts23
//
//  Created by Karissa McDaris on 1/4/19.
//  Copyright © 2019 Karissa McDaris. All rights reserved.
//

import UIKit

var contact: Contact?

class ContactDetailViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Save Button Tapped
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let contact = contact {
            ContactController.shared.updateContact(contact: contact, updatedName: nameTextField.text ?? "", updatedNumber: numberTextField.text ?? "", updatedEmail: emailTextField.text ?? "")
        } else {
            ContactController.shared.createNewContact(name: nameTextField.text ?? "", number: numberTextField.text ?? "", email: emailTextField.text ?? "", completion: nil)
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Update Views
    func updateViews() {
        if let contact = contact {
            nameTextField.text = contact.name
            numberTextField.text = contact.number
            emailTextField.text = contact.email
        }
    }
}
