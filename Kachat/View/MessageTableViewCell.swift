//
//  MessageTableViewCell.swift
//  Kachat
//
//  Created by Gino Tasis on 3/9/22.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    var messages = MessageData()

    override func awakeFromNib() {
        super.awakeFromNib()
      
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
