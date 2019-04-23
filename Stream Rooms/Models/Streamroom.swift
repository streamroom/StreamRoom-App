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
    @NSManaged var name: String?
    @NSManaged var identity: String?
    @NSManaged var owner: PFUser?
    @NSManaged var image: PFFileObject?
    @NSManaged var genres: [Genre]?
    @NSManaged var artists: [Artist]?
    @NSManaged var users: [PFUser]?
    @NSManaged var isPrivate: NSNumber?
    @NSManaged var dislikedGenres: [Genre]?
    @NSManaged var dislikedArtists: [Genre]?
    
    class func parseClassName() -> String {
        return "StreamRoom"
    }
    
    class func createStreamroom(name: String, image: UIImage, owner: PFUser, privacy: NSNumber, withCompletion completion: PFBooleanResultBlock?){
        
        let room = Streamroom()
        
        room.name = name
        room.identity = UUID().uuidString
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
