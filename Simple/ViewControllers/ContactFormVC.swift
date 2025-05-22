//
//  ContactDetailView.swift
//  Simple
//
//  Created by Sathsara Dharmarathna on 2025-05-22.
//

import UIKit

class ContactFormVC: BaseVC {
    
    var vm = ContactFormVM()
    var inputType:UpdateFormType?
    var model:Contact?
    
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var contactTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTxt.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        contactTxt.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        updateBtn.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUi()
    }
    
    func updateUi(){
        profileImg.addCornerRadious(radious: profileImg.frame.size.height/2)
        switch inputType {
        case .new:
            self.title = Constants.Titles.CreateNew
            updateBtn.setTitle(Constants.ButtonTexts.Create, for: .normal)
            nameTxt.text = "";
            contactTxt.text = "";
        case .exists:
            self.title = Constants.Titles.EditView
            updateBtn.setTitle(Constants.ButtonTexts.Update, for: .normal)
            nameTxt.text = model?.fullName
            contactTxt.text = model?.phoneNumber
        default:
            print("None")
        }
    }
    
    @objc func textFieldsDidChange() {
        updateBtn.isEnabled = validateTextFields()
    }
    
    func validateTextFields() -> Bool {
        guard let name = nameTxt.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard let phone = contactTxt.text, isValidPhoneNumber(phone) else {
            return false
        }
        return true
    }
    
    func createNew(){
        if validateTextFields() {
            vm.addContact(fullName: nameTxt.text!, phoneNumber: contactTxt.text!) { status in
                if(status){
                    self.showAlert(title: Constants.AlertMessages.Success, message: Constants.AlertMessages.SaveSuccess, needAction: true)
                }else{
                    self.showAlert(title: Constants.AlertMessages.Fail, message: Constants.AlertMessages.SaveFail, needAction: true)
                }
            }
        }
    }
    
    func updateExists(){
        if validateTextFields() {
            let data = Contact(id: model!.id, fullName: nameTxt.text!, phoneNumber: contactTxt.text!)
            vm.updateContact(contact: data) { status in
                if(status){
                    self.showAlert(title: Constants.AlertMessages.Success, message: Constants.AlertMessages.UpdateSuccess, needAction: true)
                }else{
                    self.showAlert(title: Constants.AlertMessages.Fail, message: Constants.AlertMessages.UpdateFail, needAction: true)
                }
            }
        }
    }
    
    func showAlert(title:String,message:String,needAction:Bool){
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        if needAction{
            alert.addAction(UIAlertAction(title: Constants.AlertMessages.OK, style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
        }else{
            alert.addAction(UIAlertAction(title: Constants.AlertMessages.OK, style: .default))
        }
        self.present(alert, animated: true)
    }
    
    @IBAction func didSubmit(_ sender: Any) {
        switch inputType {
        case .new:
            createNew()
        case .exists:
            updateExists()
        case .none:
            print("None")
        }
    }
}
