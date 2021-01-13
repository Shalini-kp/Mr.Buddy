//
//  SenderTableViewCell.swift
//  Mr.Buddy
//
//  Copyright © 2020 Shalini. All rights reserved.
//

import UIKit

class SenderTableViewCell: UITableViewCell {

    @IBOutlet weak var botTextView: UITextView!
    @IBOutlet weak var botImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
