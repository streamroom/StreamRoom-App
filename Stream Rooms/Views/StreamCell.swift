//
//  StreamCell.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/16/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse

class StreamCell: UICollectionViewCell {
    
    @IBOutlet weak var streamName: UILabel!
    @IBOutlet weak var streamImage: UIImageView!
    
    var stream: Streamroom? {
        didSet {
            streamName.text = stream?.name
            let imageData = stream?.image
            imageData?.getDataInBackground(block: { (data, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print("Image was found!")
                    self.streamImage.image = UIImage(data: data!)
                }
            })
            
        }
    }
    
}
