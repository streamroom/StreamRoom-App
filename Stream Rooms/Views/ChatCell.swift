//
//  ChatCell.swift
//  Stream Rooms
//
//  Created by Jorge Alejandre on 4/23/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var chatMessage: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var message: PFObject! {
        didSet {
            chatMessage.text = message["text"] as! String
            if let user = message["user"] as? PFUser {
                usernameLabel.text = user.username
            } else {usernameLabel.text = "<No Username>"}
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM d, yyyy h:mm a"
            dateLabel.text = dateFormatterPrint.string(from: message.createdAt!)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
