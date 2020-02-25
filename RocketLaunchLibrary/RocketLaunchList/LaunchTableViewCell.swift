//
//  LaunchTableViewCell.swift
//  RocketLaunchLibrary
//
//  Created by Ihor on 24.02.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fill(launch: RocketLaunch) {
        nameLabel.text = launch.name
    }
    
    // MARK: - Implementation
    
    @IBOutlet private weak var nameLabel: UILabel!
}
