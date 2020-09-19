//
//  LearningSyllabusCoveredTVCell.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/3/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class LearningSyllabusCoveredTVCell: UITableViewCell {

    
    @IBOutlet weak var lblSyllabusName: UILabel!
    @IBOutlet weak var progressSyllabus: NSLayoutConstraint!
    @IBOutlet weak var lblShowPercentageValue: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
            }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
