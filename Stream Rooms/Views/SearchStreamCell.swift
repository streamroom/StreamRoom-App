//
//  SearchStreamCell.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/25/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit

class SearchStreamCell: UITableViewCell {

    @IBOutlet weak var streamroomName: UILabel!
    @IBOutlet weak var streamroomOwner: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
