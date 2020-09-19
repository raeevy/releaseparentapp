//
//  subjectAssignedTVCell.swift
//  Parent EdConnect
//
//  Created by Work on 06/08/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class subjectAssignedTVCell: UITableViewCell {
    
    
    @IBOutlet weak var viewInsideCell: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblAttemptedDate: UILabel!
    @IBOutlet weak var lblAttemptedTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
