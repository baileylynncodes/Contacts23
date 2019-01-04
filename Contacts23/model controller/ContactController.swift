//
//  ContactController.swift
//  Contacts23
//
//  Created by Karissa McDaris on 1/4/19.
//  Copyright © 2019 Karissa McDaris. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    //MARK: - Shared Instance
    static let shared = ContactController()
    private init(){}
    
    //MARK: - SoT
    var contacts: [Contact] = []
    
    //MARK: - CRUD functions
        //create
    func createNewContact(name: String, number: String, email: String, completion:((Contact?) -> Void)?) {
        let newContact = Contact(name: name, number: number, email: email)
        self.contacts.append(newContact)
        
        CKContainer.default().publicCloudDatabase.save(newContact.asCKRecord) { (record, error) in
            if let error = error {
                print("There was an error saving contact: \(error.localizedDescription)")
                completion?(nil)
                return
            }
            
            guard let record = record else {completion?(nil); return}
            let contact = Contact(ckRecord: record)
            completion?(contact)
        }
    }
    
        //update
    func updateContact(contact:Contact, updatedName:String, updatedNumber: String, updatedEmail: String) {
        contact.name = updatedName
        contact.number = updatedNumber
        contact.email = updatedEmail
    }
    
    
    //MARK: - Fetch
    func fetchAllContacts(completion: @escaping ([Contact]) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Keys.contactRecordType, predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let records = records else { completion([]); return}
            let fetchedContacts = records.compactMap { Contact(ckRecord: $0)}
            self.contacts = fetchedContacts
            completion(fetchedContacts)
        }
    }
}
