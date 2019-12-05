//
//  AddContactViewController.swift
//  mad2_telegramme_revised
//
//  Created by Jm San Diego on 28/11/19.
//  Copyright © 2019 Jm San Diego. All rights reserved.
//

import UIKit

class AddContactViewController : UIViewController {
    
    var contactController:ContactController = ContactController()
    
    @IBOutlet weak var firstNameFld: UITextField!
    @IBOutlet weak var lastNameFld: UITextField!
    @IBOutlet weak var mobileNoFld: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancelBtn(_ sender: Any) {
        resetTxtFlds()
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func createBtn(_ sender: Any) {
        
        let firstName = firstNameFld.text
        let lastName = lastNameFld.text
        let mobileNo = mobileNoFld.text
        
        let contact: Contact = Contact(firstName: firstName!, lastName: lastName!, mobileNo: mobileNo!, profileImageName: "test1")
        contactController.AddContact(contact: contact);
        resetTxtFlds()
        self.tabBarController?.selectedIndex = 1
    }
    
    func resetTxtFlds() {
        firstNameFld.text = ""
        lastNameFld.text = ""
        mobileNoFld.text = ""
    }
    
}
