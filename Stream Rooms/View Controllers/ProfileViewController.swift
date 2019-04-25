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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.image = UIImage(named: "index")
        usernameLabel.text = "Barack Obama"
       
    }
    
    
    @IBAction func onEdit(_ sender: Any) {
        self.performSegue(withIdentifier: "editSegue", sender: nil)
    }
    
    
    
    
    
    
    
    
    
    
    

}
