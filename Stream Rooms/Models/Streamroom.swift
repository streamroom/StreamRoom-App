//
//  Streamroom.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/16/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import Foundation
import Parse

class Streamroom: PFObject, PFSubclassing {
    var name: String?
    var id: UUID?
    var owner: PFUser?
    var image: PFFileObject?
    var genres: [Genre]?
    var artists: [Artist]?
    var users: [PFUser]?
    var isPrivate: Bool?
    var dislikedGenres: [Genre]?
    var dislikedArtists: [Genre]?
    
    class func parseClassName() -> String {
        return "StreamRoom"
    }
    
    class func createStreamroom(name: String, image: UIImage, owner: PFUser, privacy: Bool, withCompletion completion: PFBooleanResultBlock?){
        
        let room = Streamroom()
        
        room.name = name
        room.id = UUID()
        room.image = getPFFileFromImage(image: image)
        room.owner = owner
        room.isPrivate = privacy
        room.genres = []
        room.artists = []
        room.users = []
        room.dislikedGenres = []
        room.dislikedArtists = []
        room.users?.append(owner)
        
        room.saveInBackground { (success, error) in
            if (success) {
                print("\(name) - room created")
            } else {
                
            }
        }
        
        
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFileObject? {
        if let image = image {
            if let imageData = image.pngData() {
                return PFFileObject(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
}
