//
//  liveClassReportTVCell.swift
//  Parent EdConnect
//
//  Created by Work on 28/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class liveClassReportTVCell: UITableViewCell {

    
    @IBOutlet weak var imgSubIcon: UIImageView!
    
    @IBOutlet weak var lblSubName: UILabel!
    
    @IBOutlet weak var lblSessionDate: UILabel!
    
    @IBOutlet weak var lblFacultyName: UILabel!
    
    @IBOutlet weak var viewInsideCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
