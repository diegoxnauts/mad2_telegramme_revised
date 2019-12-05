//
//  Message.swift
//  mad2_telegramme_revised
//
//  Created by Jm San Diego on 1/12/19.
//  Copyright © 2019 Jm San Diego. All rights reserved.
//

import UIKit

class Message {
    var date: Date
    var isSender: Bool
    var text: String
    
    init(date: Date, isSender: Bool, text: String) {
        self.date = date
        self.isSender = isSender
        self.text = text
    }
    
}
