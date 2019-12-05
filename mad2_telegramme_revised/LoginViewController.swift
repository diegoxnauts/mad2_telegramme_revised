//
//  ViewController.swift
//  mad2_telegramme_revised
//
//  Created by Jm San Diego on 28/11/19.
//  Copyright © 2019 Jm San Diego. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usrNameFld: UITextField!
    @IBOutlet weak var pwdFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtn(_ sender: Any) {
        if true { // if username and password is correct
            let storyboard = UIStoryboard(name: "Content", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Content")
            
            vc.modalPresentationStyle = .fullScreen // try without fullscreen
            present(vc, animated: true, completion: nil)
            
        }
    }
     

}

