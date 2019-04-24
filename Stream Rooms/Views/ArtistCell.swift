//
//  ArtistCell.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/23/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import LTMorphingLabel

class ArtistCell: UITableViewCell {

    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        artistLabel.morphingEffect
//        artistLabel.start()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
