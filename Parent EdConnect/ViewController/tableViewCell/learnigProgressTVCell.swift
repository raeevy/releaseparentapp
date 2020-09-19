//
//  learnigProgressTVCell.swift
//  Parent EdConnect
//
//  Created by Work on 07/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class learnigProgressTVCell: UITableViewCell {

    @IBOutlet weak var viewAvgScore: UIView!
    @IBOutlet weak var viewKeyFocusArea: UIView!
    @IBOutlet weak var barFocusArea: UIProgressView!
    
    @IBOutlet weak var viewLoderTop: CircularArc!
    
    @IBOutlet weak var viewMonthPerformance: UIView!
    @IBOutlet weak var viewloadCorrectRespTime: CircularView!
    @IBOutlet weak var viewloadavrTestDuration: CircularView!
    @IBOutlet weak var viewStatictics: UIView!
    @IBOutlet weak var btnViewTestAttempt: UIButton!
    @IBOutlet weak var barAccuracy: UIProgressView!
    @IBOutlet weak var viewAccuracy: UIView!
    @IBOutlet weak var viewGraphAvgScore: UIView!
    @IBOutlet weak var viewGreenCircal: UIView!
    @IBOutlet weak var viewRedC: UIView!
    @IBOutlet weak var viewSilverC: UIView!
    ///Overview Cell1 Outlate.
    @IBOutlet weak var lblSubName: UILabel!
    @IBOutlet weak var lblShowNoOfTakenTast: UILabel!
    @IBOutlet weak var lblCorrectAnsShow: UILabel!
    @IBOutlet weak var lblWrongAns: UILabel!
    @IBOutlet weak var lblSkipedAns: UILabel!
    @IBOutlet weak var lblAvrageScore: UILabel!
    @IBOutlet weak var lblShowScoreOnTop: UILabel!
    @IBOutlet weak var lblShowAccurencyValue: UILabel!
    @IBOutlet weak var lblShowOutOfValue: UILabel!
    //Third Cell Total Time.
    @IBOutlet weak var lblTotalTimeShow: UILabel!
    @IBOutlet weak var lblCorrectRecTimeShow: UILabel!
    @IBOutlet weak var lblAvrageTimeShow: UILabel!
    //Seven Cell .
    @IBOutlet weak var lblTargetValueShow: UILabel!
    @IBOutlet weak var lblSroreValueShow: UILabel!
    @IBOutlet weak var progressBarScoreShow: UIProgressView!
    @IBOutlet weak var lblChapNameShow: UILabel!
    @IBOutlet weak var btnShowNativeValue: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
