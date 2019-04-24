//
//  CreateStreamViewController.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/16/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse

class CreateStreamViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var createStreamroomButton: UIButton!
    @IBOutlet weak var privacySwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.isUserInteractionEnabled = true
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        createStreamroomButton.layer.cornerRadius = 20
        imagePicker.addGestureRecognizer(pictureTap)

    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        chooseImage()
    }
    
    func chooseImage() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the image captured by the UIImagePickerController
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        guard let editedImage = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        imagePicker.image = editedImage
        
        dismiss(animated: true, completion: nil)
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
        self.performSegue(withIdentifier: "createToHome", sender: nil)
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
