//
//  Contact.swift
//  mad2_telegramme_revised
//
//  Created by Jm San Diego on 28/11/19.
//  Copyright © 2019 Jm San Diego. All rights reserved.
//

import UIKit

class Contact {
    var firstName: String
    var lastName: String
    var mobileNo: String
    var profileImageName: String
    
    init(firstName: String, lastName: String, mobileNo: String, profileImageName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.mobileNo = mobileNo
        self.profileImageName = profileImageName
    }
}
