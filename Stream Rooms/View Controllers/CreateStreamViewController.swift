//
//  CreateStreamViewController.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/16/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse

class CreateStreamViewController: UIViewController {
    
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var createStreamroomButton: UIButton!
    @IBOutlet weak var privacySwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createStreamroomButton.layer.cornerRadius = 20

    }
    
    @IBAction func onCreate(_ sender: Any) {
        let streamName = titleInput.text!
        let streamImage = imagePicker.image!
        let streamPrivacyBool = privacySwitch.isOn
        let streamPrivacy = NSNumber(booleanLiteral: streamPrivacyBool)
        
        Streamroom.createStreamroom(name: streamName, image: streamImage, owner: PFUser.current()!, privacy: streamPrivacy) { (success: Bool, error: Error?) in
            if success {
                self.performSegue(withIdentifier: "createToHome", sender: nil)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
