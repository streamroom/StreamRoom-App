//
//  EditProfileViewController.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/23/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var universityField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func onSave(_ sender: Any) {
        
        let name = PFObject(className: "name")
        let birthday = PFObject(className: "birthday")
        let gender = PFObject(className: "gender")
        let phone = PFObject(className: "phone")
        let university = PFObject(className: "university")
        
        
        name["text"] = nameField.text ?? ""
        name["user"] = PFUser.current()
        
        birthday["text"] = birthdayField.text ?? ""
        birthday["user"] = PFUser.current()
        
        gender["text"] = genderField.text ?? ""
        gender["user"] = PFUser.current()
        
        phone["text"] = phoneField.text ?? ""
        phone["user"] = PFUser.current()
        
        university["text"] = universityField.text ?? ""
        university["user"] = PFUser.current()
        
        
        name.saveInBackground { (success, error) in
            if success {
                print("The name was saved!")
                self.nameField.text = ""
            } else if let error = error {
                print("Problem saving name: \(error.localizedDescription)")
            }
        }
        
        birthday.saveInBackground { (success, error) in
            if success {
                print("The birthday was saved!")
                self.birthdayField.text = ""
            } else if let error = error {
                print("Problem saving birthday: \(error.localizedDescription)")
            }
        }
        
        gender.saveInBackground { (success, error) in
            if success {
                print("The gender was saved!")
                self.genderField.text = ""
            } else if let error = error {
                print("Problem saving gender: \(error.localizedDescription)")
            }
        }
        
        phone.saveInBackground { (success, error) in
            if success {
                print("The phone was saved!")
                self.phoneField.text = ""
            } else if let error = error {
                print("Problem saving phone: \(error.localizedDescription)")
            }
        }
        
        university.saveInBackground { (success, error) in
            if success {
                print("The university was saved!")
                self.universityField.text = ""
            } else if let error = error {
                print("Problem saving university: \(error.localizedDescription)")
            }
        }
    
        
        
        
        
    }
    

}
