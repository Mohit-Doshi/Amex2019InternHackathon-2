//
//  CarPoolTableViewCell.swift
//  FindAPool
//
//  Created by Mohit on 08/08/19.
//  Copyright © 2019 forty-two. All rights reserved.
//

import UIKit

class CarPoolTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var DurationLabel: UILabel!
    @IBOutlet weak var DistanceLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
