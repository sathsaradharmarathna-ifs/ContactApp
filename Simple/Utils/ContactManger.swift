//
//  CotactManger.swift
//  Simple
//
//  Created by Sathsara Dharmarathna on 2025-05-22.
//

import Foundation

class ContactManager {
    static let shared = ContactManager()
    private let contactsKey = Constants.Keys.ContactsKey
    private let lastIdKey = Constants.Keys.LastIdKey

    private init() {}

    // Get all contacts
    func getAll(completion: @escaping ([Contact]) -> Void) {
        if let data = UserDefaults.standard.data(forKey: contactsKey),
           let contacts = try? JSONDecoder().decode([Contact].self, from: data) {
            completion(contacts)
        } else {
            completion([])
        }
    }

    // Generate next auto-increment ID
    private func generateNextId() -> String {
        let lastId = UserDefaults.standard.integer(forKey: lastIdKey)
        let nextId = lastId + 1
        UserDefaults.standard.set(nextId, forKey: lastIdKey)
        return String(nextId)
    }

    // Add contact (ID auto-generated)
    func add(fullName: String, phoneNumber: String, completion: @escaping (Bool) -> Void) {
        let newContact = Contact(id: generateNextId(), fullName: fullName, phoneNumber: phoneNumber)
        getAll { contacts in
            var updated = contacts
            updated.append(newContact)
            self.save(contacts: updated, completion: completion)
        }
    }

    // Update contact
    func update(contact: Contact, completion: @escaping (Bool) -> Void) {
        getAll { contacts in
            var updated = contacts
            if let index = updated.firstIndex(where: { $0.id == contact.id }) {
                updated[index] = contact
                self.save(contacts: updated, completion: completion)
            } else {
                completion(false)
            }
        }
    }

    // Delete contact
    func delete(id: String, completion: @escaping (Bool) -> Void) {
        getAll { contacts in
            let updated = contacts.filter { $0.id != id }
            self.save(contacts: updated, completion: completion)
        }
    }

    // Save contact list to UserDefaults
    private func save(contacts: [Contact], completion: @escaping (Bool) -> Void) {
        if let data = try? JSONEncoder().encode(contacts) {
            UserDefaults.standard.set(data, forKey: contactsKey)
            completion(true)
        } else {
            completion(false)
        }
    }
}

