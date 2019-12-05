//
//  ContactController.swift
//  mad2_telegramme_revised
//
//  Created by Jm San Diego on 1/12/19.
//  Copyright © 2019 Jm San Diego. All rights reserved.
//

import UIKit
import CoreData

// Contact CRUD with the Messages
class ContactController {
    
    // MARK: Create
    func AddContact(contact: Contact)
    {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDContact", in: context)
        
        let contactNSObj = NSManagedObject(entity: entity!, insertInto: context)
        
        contactNSObj.setValue(contact.firstName, forKeyPath: "firstName")
        contactNSObj.setValue(contact.lastName, forKeyPath: "lastName")
        contactNSObj.setValue(contact.mobileNo, forKeyPath: "mobileNo")
        contactNSObj.setValue(contact.profileImageName, forKeyPath: "profileImageName")
        
        // Save the object
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // MARK: Read
    func retrieveAllContact()->[Contact]
    {
        var contactNSObjList:[NSManagedObject] = []
        var contactList:[Contact] = []
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        
        do {
            contactNSObjList = try context.fetch(fetchRequest)
            
            for c in contactNSObjList {
                let firstName = c.value(forKeyPath: "firstName") as? String
                let lastName = c.value(forKeyPath: "lastName") as? String
                let mobileNo = c.value(forKeyPath: "mobileNo") as? String
                let profileImageName = c.value(forKeyPath: "profileImageName") as? String
                
                let contact:Contact = Contact(firstName: firstName!, lastName: lastName!, mobileNo: mobileNo!, profileImageName: profileImageName!)
                
                contactList.append(contact)
            }
        } catch let error as NSError {
            print ("Could not fetch. \(error) \(error.userInfo)")
        }
        
        return contactList
    }
    
    // MARK: Update
    func updateContact(mobileno:String, newContact: Contact) {
        // update the message property as well
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        
        fetchRequest.predicate = NSPredicate(format: "mobileNo = %@", mobileno)
        
        do {
            let contactNSObjList = try context.fetch(fetchRequest)
            
            let contactNSObj = contactNSObjList[0]
            contactNSObj.setValue(newContact.firstName, forKey: "firstName")
            contactNSObj.setValue(newContact.lastName, forKey: "lastName")
            contactNSObj.setValue(newContact.mobileNo, forKey: "mobileNo")
            contactNSObj.setValue(newContact.profileImageName, forKey: "profileImageName")
            do {
                try context.save()
            } catch {
                print (error)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: Delete
    func deleteContact(mobileno:String)
    {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        
        fetchRequest.predicate = NSPredicate(format: "mobileNo = %@", mobileno)
        
        do {
            let contactNSObjList = try context.fetch(fetchRequest)
            
            let contactNSObj = contactNSObjList[0]
            context.delete(contactNSObj)
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: Relationship
    
    func retrieveMessagesbyContact(contact: Contact)->[Message]
    {
        var messageList:[Message] = []
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDMessage")
        
        fetchRequest.predicate = NSPredicate(format: "contact.mobileNo = %@", contact.mobileNo)
        
        do {
            let messageNSObjList = try context.fetch(fetchRequest)
            for m in messageNSObjList {
                let text = m.value(forKeyPath: "text") as? String
                let isSender = m.value(forKeyPath: "isSender") as? Bool
                let date = m.value(forKeyPath: "date") as? Date
                
                let mobileNo = m.value(forKeyPath: "contact.mobileNo") as? String
                
                // Just to test
                print ("text: \(text!) mobileNo: \(mobileNo!)")
                
                let message:Message = Message(date: date!, isSender: isSender!, text: text!)
                
                messageList.append(message)
            }
        } catch let error as NSError {
            print ("Could not fetch. \(error) \(error.userInfo)")
        }
        return messageList
    }
    
}
