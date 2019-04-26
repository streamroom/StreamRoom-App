//
//  SearchUserCell.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/25/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import PMSuperButton

class SearchUserCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addFriend: PMSuperButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
