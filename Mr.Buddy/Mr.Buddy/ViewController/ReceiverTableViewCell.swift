//
//  ReceiverTableViewCell.swift
//  Mr.Buddy
//
//  Copyright © 2020 Shalini. All rights reserved.
//

import UIKit

class ReceiverTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
