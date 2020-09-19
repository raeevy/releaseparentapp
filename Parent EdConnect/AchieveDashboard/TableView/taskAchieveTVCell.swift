//
//  taskAchieveTVCell.swift
//  Parent EdConnect
//
//  Created by Work on 08/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class taskAchieveTVCell: UITableViewCell {
    
    
    @IBOutlet weak var lblSubjectName: UILabel!
    
    @IBOutlet weak var lblStartDate: UILabel!
    
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var btnDownload: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
