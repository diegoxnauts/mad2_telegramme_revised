//
//  MessagesViewController.swift
//  mad2_telegramme_revised
//
//  Created by Jm San Diego on 2/12/19.
//  Copyright © 2019 Jm San Diego. All rights reserved.
//

import UIKit

class MessageViewController: UITableViewController, UITextFieldDelegate {
    var contact: Contact?
    var messageList: [Message] = []
    var contactController: ContactController = ContactController()
    var messageController: MessageController = MessageController()
    
    @IBOutlet weak var messageFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageFld.delegate = self
        self.tableView.reloadData() // refresh table data
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageList = contactController.retrieveMessagesbyContact(contact: contact!)
        self.tableView.reloadData()
    }
    
    
    // MARK: Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageFld.resignFirstResponder()
        
        let text = messageFld.text
        let isSender = true
        let date = Date()
        
        let message: Message = Message(date: date, isSender: isSender, text: text!)
        
        messageController.AddMessageToContact(contact: contact!, message: message)
        messageList = contactController.retrieveMessagesbyContact(contact: contact!)
        self.tableView.reloadData()
        return true
    }
    
    @IBAction func editBtn(_ sender: Any) {
        performSegue(withIdentifier: "ToEditContact", sender: contact)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEditContact" {
            let destVC = segue.destination as! EditContactViewController
            destVC.contact = sender as? Contact
        }
    }
    
    
    // MARK: TABLE: Title & Headers
    
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
        return messageList.count
    }
    
    // MARK: Specify Cell Content
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        let message = messageList[indexPath.row]
        cell.textLabel?.text = "\(contact!.firstName) \(contact!.lastName) Sender:(\(message.isSender))"
        cell.detailTextLabel?.text = "\(message.text) Date: [\(message.date)]"
        return cell
    }
}
