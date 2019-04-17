//
//  Artist.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/16/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import Foundation
import Parse

class Artist: PFObject {
    var firstName: String?
    var lastName: String?
    var image: UIImage?
    
    class func parseClassName() -> String {
        return "Artist"
    }
}


