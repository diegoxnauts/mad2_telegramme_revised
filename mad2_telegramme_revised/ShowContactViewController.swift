//
//  ShowContactViewController.swift
//  mad2_telegramme_revised
//
//  Created by Jm San Diego on 28/11/19.
//  Copyright © 2019 Jm San Diego. All rights reserved.
//

import UIKit

class ShowContactViewController : UITableViewController {
    
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    var contactController: ContactController = ContactController()
    var contactList: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData() // refresh table data
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contactList = contactController.retrieveAllContact()
        self.tableView.reloadData()
    }
    
    // MARK: Title & Headers
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }
    
    // MARK: Specify Number of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: Specify Number of Rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    // MARK: Specify Cell Content
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)

        let contact = contactList[indexPath.row]
        cell.textLabel?.text = "\(contact.firstName) \(contact.lastName)"
        cell.detailTextLabel?.text = "\(contact.mobileNo)"
        return cell
    }
    
    // MARK: Edit Row
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let contact = contactList[indexPath.row]
            print("deleteing contact: \(contact.firstName) \(contact.lastName)")
            contactController.deleteContact(mobileno: contact.mobileNo)
            contactList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath],
            with: UITableView.RowAnimation.fade)
        }
    }
    
    // MARK: Select Row Func
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contactList[indexPath.row]
        performSegue(withIdentifier: "ToContactMessages", sender: contact)
    }
    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToContactMessages" {
            let destVC = segue.destination as! MessageViewController
            destVC.contact = sender as? Contact
        }
    }
    
    
    // MARK: Unwind segue function
    @IBAction func unwindToShowContactVC(_ sender: UIStoryboardSegue) {}
}
