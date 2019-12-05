//
//  MessageController.swift
//  mad2_telegramme_revised
//
//  Created by Jm San Diego on 1/12/19.
//  Copyright © 2019 Jm San Diego. All rights reserved.
//

import UIKit
import CoreData

class MessageController {
    
    // MARK: Create
    func AddMessageToContact(contact: Contact, message: Message)
    {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDMessage", in: context)
        
        let messageNSObj = NSManagedObject(entity: entity!, insertInto: context)
        
        messageNSObj.setValue(message.text, forKey: "text")
        messageNSObj.setValue(message.isSender, forKey: "isSender")
        messageNSObj.setValue(message.date, forKey: "date")
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        
        fetchRequest.predicate = NSPredicate(format: "mobileNo = %@", contact.mobileNo)
        
        do {
            let contactNSObjList = try context.fetch(fetchRequest)
            let contactNSObj = contactNSObjList[0]
            messageNSObj.setValue(contactNSObj, forKey: "contact")
            
            do {
                try context.save()
            } catch {
                print (error)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: Read - not req now
    
    // MARK: Update - not req now
    
    // MARK: Delete - not req now

}
