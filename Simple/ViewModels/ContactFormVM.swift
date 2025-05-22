//
//  ContactDetailVM.swift
//  Simple
//
//  Created by Sathsara Dharmarathna on 2025-05-22.
//

import Foundation

class ContactFormVM{

    func addContact(fullName: String, phoneNumber: String, completion: ((Bool) -> Void)? = nil) {
        ContactManager.shared.add(fullName: fullName, phoneNumber: phoneNumber) { status in
            completion?(status)
        }
    }
    
    func updateContact(contact:Contact, completion: ((Bool) -> Void)? = nil) {
        ContactManager.shared.update(contact: contact) { status in
            completion?(status)
        }
    }
}


