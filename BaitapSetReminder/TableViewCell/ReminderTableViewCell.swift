//
//  ReminderTableViewCell.swift
//  BaitapSetReminder
//
//  Created by MAC on 7/9/22.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var daytimeLabel: UILabel!
    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        daytimeLabel.text = "1"
        reminderLabel.text = "2"
        repeatLabel.text = "3"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
