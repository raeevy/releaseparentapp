//
//  homeTVCell.swift
//  Parent EdConnect
//
//  Created by Work on 28/06/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class homeTVCell: UITableViewCell {

    @IBOutlet weak var lblMe: UILabel!
    
    
    @IBOutlet weak var lblAvgUser: UILabel!
    @IBOutlet weak var lblTopUser: UILabel!
    
    @IBOutlet weak var lblMiddle1: UILabel!
    @IBOutlet weak var lblMiddle2: UILabel!
   
    @IBOutlet weak var lblMiddle4: UILabel!
    
    @IBOutlet weak var lblMiddle3: UILabel!
    
    
    @IBOutlet weak var lblLowestScoresSub: UILabel!
    
    @IBOutlet weak var imgLowestScore: UIImageView!
    
    @IBOutlet weak var lblLowestScore: UILabel!
    
    @IBOutlet weak var lblHigestScoreSub: UILabel!
    
    @IBOutlet weak var imgHigestScoreSub: UIImageView!
    
    @IBOutlet weak var lblHigestScore: UILabel!
    
    @IBOutlet weak var lblTotalMinutes: UILabel!
    @IBOutlet weak var lblSpeedAccuracy: UILabel!
    @IBOutlet weak var lblLevelAccuracy: UILabel!
    @IBOutlet weak var subImage: UIImageView!
    @IBOutlet weak var lblUrProgress: UILabel!
    @IBOutlet weak var lblAvgProgress: UILabel!
    @IBOutlet weak var lblSubName: UILabel!
    @IBOutlet weak var tapLowestScoreSub: UIButton!
    @IBOutlet weak var tapHighestScoreSub: UIButton!
    @IBOutlet weak var viewStatictics: CustomView!
    @IBOutlet weak var viewCorrectResponseTime: CircularView!
    @IBOutlet weak var viewAccuracyLevel: CircularView!
    @IBOutlet weak var viewHigestSub: CustomView!
    @IBOutlet weak var viewLowestSub: CustomView!
    @IBOutlet weak var viewTotalLeaning: UIView!
    @IBOutlet weak var bar1: UIProgressView!
    @IBOutlet weak var bar2: UIProgressView!
    
    
    @IBOutlet weak var lblGrph1: UILabel!
    
    @IBOutlet weak var lblGrph2: UILabel!
    
    @IBOutlet weak var lblGrph3: UILabel!
    
    @IBOutlet weak var lblGrph4: UILabel!
   
    @IBOutlet weak var lblGrph5: UILabel!
    
    @IBOutlet weak var lblGrph6: UILabel!
    
    @IBOutlet weak var lblGrph7: UILabel!
    
    @IBOutlet weak var lblGrph8: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
