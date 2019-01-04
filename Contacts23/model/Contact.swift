//
//  Contact.swift
//  Contacts23
//
//  Created by Karissa McDaris on 1/4/19.
//  Copyright © 2019 Karissa McDaris. All rights reserved.
//

import Foundation
import CloudKit

struct Keys {
    static let contactRecordType = "Contact"
    static let nameKey = "name"
    static let numberKey = "number"
    static let emailKey = "email"
}

class Contact {
    var name: String
    var number: String?
    var email: String?
    let ckRecordID: CKRecord.ID
    
    init(name: String, number: String?, email: String?, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.name = name
        self.number = number
        self.email = email
        self.ckRecordID = ckRecordID
    }
    
    var asCKRecord: CKRecord {
        let newRecord = CKRecord(recordType: Keys.contactRecordType, recordID: self.ckRecordID)
        
        newRecord.setValue(self.name, forKey: Keys.nameKey)
        newRecord.setValue(self.number, forKey: Keys.numberKey)
        newRecord.setValue(self.email, forKey: Keys.emailKey)
        
        return newRecord
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[Keys.nameKey] as? String,
            let number = ckRecord[Keys.numberKey] as? String,
            let email = ckRecord[Keys.emailKey] as? String else {return nil}
        
        self.init(name: name, number: number, email: email, ckRecordID: ckRecord.recordID)
    }
}

