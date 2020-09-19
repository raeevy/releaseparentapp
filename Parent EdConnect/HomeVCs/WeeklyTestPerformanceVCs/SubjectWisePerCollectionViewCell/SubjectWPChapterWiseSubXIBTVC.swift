//
//  SubjectWPChapterWiseSubXIBTVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/24/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class SubjectWPChapterWiseSubXIBTVC: UITableViewCell {

    @IBOutlet weak var lblChapterName: UILabel!
    @IBOutlet weak var viewContentsSubXIB: UIView!
    @IBOutlet weak var blueProgreshBarAvragePercentage: UIProgressView!
    @IBOutlet weak var lblBlueAvrageShowPercentage: UILabel!
    @IBOutlet weak var yelloFullPercentageProgressBar: UIProgressView!
    @IBOutlet weak var lblYelloFullShowPercentage: UILabel!
    
    var parentVC:SubjectWisePerformanceVC?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
