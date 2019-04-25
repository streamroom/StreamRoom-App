//
//  CreateStreamViewController.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/16/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse
import PMSuperButton

class CreateStreamViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var createStreamroomButton: PMSuperButton!
    @IBOutlet weak var privacySwitch: UISwitch!
    @IBOutlet weak var instructions: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.isUserInteractionEnabled = true
        imagePicker.layer.cornerRadius = 5
        
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imagePicker.addGestureRecognizer(pictureTap)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.dismissInstruction), userInfo: nil, repeats: false)

    }
    
    @objc func dismissInstruction() {
        UIView.animate(withDuration: 2.0) {
            self.instructions.alpha = 0
        }
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
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        guard let editedImage = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        imagePicker.image = editedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func panGestureRecognizerAction(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        view.frame.origin = translation
        if gesture.state == .ended {
            let velocity = gesture.velocity(in: view)
            if velocity.y >= 500 {
                //dismiss the view
                self.dismiss(animated: true, completion: nil)
            } else {
                //return to original position
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = CGPoint(x: 0,y: 0)
                }
            }
        }
    }
}
