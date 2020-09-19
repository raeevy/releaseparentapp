//
//  subjectAttemptedTVCell.swift
//  Parent EdConnect
//
//  Created by Work on 06/08/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class subjectAttemptedTVCell: UITableViewCell {

    
    @IBOutlet weak var lblUnderEvaluation: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var viewInsidCell: CustomView!
    @IBOutlet weak var btnAnalyse: UIButton!
    
    @IBOutlet weak var tapAnalyse: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
