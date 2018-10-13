//
//  HeaderTableViewCell.swift
//  Meal Reminder
//
//  Created by Rahul Srivastava on 10/12/18.
//  Copyright © 2018 Rahul Srivastava. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setDataForCell(title: String) {
        
        sectionTitleLabel.text = title.capitalizingFirstLetter()
    }
    
}
