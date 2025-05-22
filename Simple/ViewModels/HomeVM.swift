//
//  HomeVM.swift
//  Simple
//
//  Created by Sathsara Dharmarathna on 2025-05-22.
//

import Foundation

class HomeVM{
    
    init() {
        
    }
    
    func getContacts(completion: (([Contact]) -> Void)? = nil) {
        ContactManager.shared.getAll { contacts in
            completion?(contacts)
        }
    }
    
    func deleteContact(contactId:String, completion: ((Bool) -> Void)? = nil) {
        ContactManager.shared.delete(id: contactId) { status in
            completion?(status)
        }
    }
}
