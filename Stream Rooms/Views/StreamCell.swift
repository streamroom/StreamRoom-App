//
//  StreamCell.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/25/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse


class StreamCell: UITableViewCell {
    
    @IBOutlet weak var streamName: UILabel!
    @IBOutlet weak var streamImage: UIImageView!
    
    
    var stream: Streamroom?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
