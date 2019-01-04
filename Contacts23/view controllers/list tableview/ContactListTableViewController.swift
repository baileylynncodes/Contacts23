//
//  ContactListTableViewController.swift
//  Contacts23
//
//  Created by Karissa McDaris on 1/4/19.
//  Copyright © 2019 Karissa McDaris. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    //MARK: - SoT
    var contact: Contact?
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactController.shared.fetchAllContacts { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Refresh
    @IBAction func refreshButtonTapped(_ sender: Any) {
        ContactController.shared.fetchAllContacts { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return ContactController.shared.contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let contact = ContactController.shared.contacts[indexPath.row]
        cell.textLabel?.text = contact.name

        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateContact" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let destinationVC = segue.destination as? ContactListTableViewController
            let contact = ContactController.shared.contacts[indexPath.row]
            destinationVC?.contact = contact
        }
    }
}
