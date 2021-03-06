//
//  ViewController.swift
//  Stream Rooms
//
//  Created by Jorge Alejandre on 4/3/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse
import PMSuperButton
import TweeTextField

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: TweeAttributedTextField!
    @IBOutlet weak var passwordField: TweeAttributedTextField!
    
    
    @IBOutlet weak var loginButton: PMSuperButton!
    
    @IBOutlet weak var registerButton: PMSuperButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func roundButtons() {
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
        
        
        
    }
    
    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil{
                UserDefaults.standard.set(true, forKey: "userLoggedIn")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    @IBAction func onRegister(_ sender: Any) {
        let user = PFUser()
        
        user.username = usernameField.text
        user.password = passwordField.text
        let friendArray: [PFUser] = []
        let requestArray: [PFUser] = []
        let likedGenres: [String] = []
        let likedArtists: [String] = []
        
        user.add(friendArray, forKey: "friends")
        user.add(requestArray, forKey: "requests")
        user.add(likedGenres, forKey: "genres")
        user.add(likedArtists, forKey: "artists")
        
        user.signUpInBackground { (success, error) in
            if success{
                UserDefaults.standard.set(true, forKey: "userLoggedIn")
                self.performSegue(withIdentifier: "newUser", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func loginUser() {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    
    
}

