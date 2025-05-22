//
//  Constants.swift
//  Simple
//
//  Created by Sathsara Dharmarathna on 2025-05-22.
//

struct Constants {
    struct Keys {
        static let ContactsKey = "contacts"
        static let LastIdKey = "lastContactId"
    }
    
    struct Storyboards {
        static let Home = "Home"
    }

    struct ViewControllers {
        static let HomeVC = "HomeVC"
        static let ContactFormVC = "ContactFormVC"
    }
    
    struct ViewCells {
        static let ContactCell = "ContactCell"
    }
    
    struct ButtonTexts {
        static let Create = "Create"
        static let Update = "Update"
        static let Edit = "Edit"
        static let Delete = "Delete"
        static let Cancel = "Cancel"
    }
    
    struct Titles {
        static let CreateNew = "Create New"
        static let EditView = "Edit Details"
    }
    
    struct AlertMessages {
        static let NameError = "Name cannot be empty"
        static let ContactError = "Enter a valid phone number"
        static let ValidationError = "Validation Error"
        static let OK = "OK"
        static let Success = "Success"
        static let Fail = "Fail"
        static let SaveSuccess = "Save Success !"
        static let SaveFail = "Save Fail !"
        static let UpdateSuccess = "Update Success !"
        static let UpdateFail = "Update Fail !"
        static let SureMessage = "Are you sure?"
        static let DeleteConfirm = "Do you really want to delete this item?"

    }
}
