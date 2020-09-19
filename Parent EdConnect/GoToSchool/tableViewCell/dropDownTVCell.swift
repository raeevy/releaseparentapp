//
//  dropDownTVCell.swift
//  Parent EdConnect
//
//  Created by Work on 09/08/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class dropDownTVCell: UITableViewCell {

    
    @IBOutlet weak var lblSubject: UILabel!
    
    @IBOutlet weak var btnCheckBox: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
