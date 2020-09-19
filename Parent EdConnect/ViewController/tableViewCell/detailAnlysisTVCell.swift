//
//  detailAnlysisTVCell.swift
//  Parent EdConnect
//
//  Created by Work on 03/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class detailAnlysisTVCell: UITableViewCell {

    @IBOutlet weak var lblRecentSubName: UILabel!
   
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDynamicLink: UILabel!
    
    
    @IBOutlet weak var barScore: UIProgressView!
    
    @IBOutlet weak var lblScoreProgress: UILabel!
    @IBOutlet weak var barPrerformance: UIProgressView!
    @IBOutlet weak var barSyllabusCov: UIProgressView!
    @IBOutlet weak var lblPerformance: UILabel!
    @IBOutlet weak var lblSubCoverage: UILabel!
    @IBOutlet weak var lblSubName: UILabel!
    @IBOutlet weak var imgSubject: UIImageView!    
    @IBOutlet weak var viewRecntlyTakenTest: CustomView!
    @IBOutlet weak var vewSubject: CustomView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
