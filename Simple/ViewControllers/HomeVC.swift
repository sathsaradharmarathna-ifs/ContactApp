//
//  HomeView.swift
//  Simple
//
//  Created by Sathsara Dharmarathna on 2025-05-19.
//

import UIKit

class HomeVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contactSearchBar: UISearchBar!
    
    var vm = HomeVM()
    var contactsList:[Contact] = [];
    var filteredContacts: [Contact] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactSearchBar.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchContacts()
    }
    
    override func initTableView() {
        tableView.delegate  = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.ViewCells.ContactCell, bundle: nil), forCellReuseIdentifier: Constants.ViewCells.ContactCell)
        tableView.separatorStyle = .none
    }
    
    func setupUI(){
        self.title = Constants.Storyboards.Home
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        addColorToNavBar()
    }
    
    func fetchContacts(){
        vm.getContacts { list in
            self.contactsList = list
            self.filteredContacts = list
            self.tableView.reloadData()
        }
    }
    
    @objc func addButtonTapped() {
        gotoDetailView(model: nil,type: .new)
    }
    
    func gotoDetailView(model:Contact?,type:UpdateFormType){
        let homeStoryboard = UIStoryboard(name: Constants.Storyboards.Home, bundle: nil)
        guard let contactForm = homeStoryboard.instantiateViewController(withIdentifier: Constants.ViewControllers.ContactFormVC) as? ContactFormVC else { return }
        contactForm.inputType = type
        if(model != nil){
            contactForm.model = model
        }
        self.navigationController?.pushViewController(contactForm, animated: true)
    }
}

extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredContacts.count : contactsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ViewCells.ContactCell, for: indexPath) as? ContactCell else {
            fatalError("Could not dequeue LogCell")
        }
        let contact = isSearching ? filteredContacts[indexPath.row] : contactsList[indexPath.row]
        cell.setData(model: contact)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = isSearching ? filteredContacts[indexPath.row] : contactsList[indexPath.row]
        gotoDetailView(model: selectedContact, type: .exists)
    }
    
    func tableView(_ tableView: UITableView,trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.ButtonTexts.Delete) { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            aletDeleteData(contactId: contactsList[indexPath.row].id)
            completionHandler(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: Constants.ButtonTexts.Edit) { (action, view, completionHandler) in
            self.gotoDetailView(model: self.contactsList[indexPath.row],type: .exists)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .systemRed
        editAction.backgroundColor = .systemBlue
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return config
    }
}

extension HomeVC:CellButtonActions{
    
    func didEditCell(model: Contact) {
        gotoDetailView(model: model,type:.exists)
    }
    
    func didDeleteCell(model: Contact) {
        aletDeleteData(contactId: model.id)
    }
    
    func aletDeleteData(contactId:String){
        let alert = UIAlertController(title: Constants.AlertMessages.SureMessage,message: Constants.AlertMessages.DeleteConfirm,preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ButtonTexts.Cancel, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: Constants.ButtonTexts.Delete, style: .destructive, handler: { _ in
            self.vm.deleteContact(contactId: contactId) { status in
                self.fetchContacts()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension HomeVC:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredContacts = contactsList
        } else {
            isSearching = true
            filteredContacts = contactsList.filter { contact in
                return contact.fullName.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}
