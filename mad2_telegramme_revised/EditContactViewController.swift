//
//  EditContactViewController.swift
//  mad2_telegramme_revised
//
//  Created by Jm San Diego on 2/12/19.
//  Copyright © 2019 Jm San Diego. All rights reserved.
//

import UIKit

class EditContactViewController : UIViewController {
    
    var contact: Contact?
    var contactController: ContactController = ContactController()
    
    @IBOutlet weak var firstNameFld: UITextField!
    @IBOutlet weak var lastNameFld: UITextField!
    @IBOutlet weak var mobileNoFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue,sender: Any?) {
        let oldMobileNo = contact?.mobileNo
        contact?.firstName = firstNameFld.text!
        contact?.lastName = lastNameFld.text!
        contact?.mobileNo = mobileNoFld.text!
        
        contactController.updateContact(mobileno: oldMobileNo!, newContact: contact!)
        resetTxtFlds()
    }
    
    func resetTxtFlds() {
        firstNameFld.text = ""
        lastNameFld.text = ""
        mobileNoFld.text = ""
    }
    
}
