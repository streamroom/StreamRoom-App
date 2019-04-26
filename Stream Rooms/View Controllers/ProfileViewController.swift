//
//  ProfileViewController.swift
//  Stream Rooms
//
//  Created by Jorge Alejandre on 4/6/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    
    
    var name: [PFObject?] = []
    var birthday: [PFObject?] = []
    var gender: [PFObject?] = []
    var phone: [PFObject?] = []
    var university: [PFObject?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetchProfile()
    }
    
    
    @IBAction func onEdit(_ sender: Any) {
        self.performSegue(withIdentifier: "editSegue", sender: nil)
    }
    
    
    
    func fetchProfile() {
        let query = PFQuery(className: "name")
        query.addDescendingOrder("createdAt")
        query.limit = 1
        query.includeKeys(["user", "createdAt"])
        query.findObjectsInBackground { (name, error) in
            if let name = name {
                self.name = name
            } else {
                print(error!.localizedDescription)
            }
        }
        query.findObjectsInBackground { (birthday, error) in
            if let birthday = birthday {
                self.birthday = birthday
            } else {
                print(error!.localizedDescription)
            }
        }
        query.findObjectsInBackground { (gender, error) in
            if let gender = gender {
                self.gender = gender
            } else {
                print(error!.localizedDescription)
            }
        }
        query.findObjectsInBackground { (phone, error) in
            if let phone = phone {
                self.phone = phone
            } else {
                print(error!.localizedDescription)
            }
        }
        query.findObjectsInBackground { (university, error) in
            if let university = university {
                self.university = university
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    

}
