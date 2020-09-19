//
//  sideBarTVCell.swift
//  Parent EdConnect
//
//  Created by Work on 15/06/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class sideBarTVCell: UITableViewCell {

    
    @IBOutlet weak var imgSideBarIcon: UIImageView!
    @IBOutlet weak var lblNameMod: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
