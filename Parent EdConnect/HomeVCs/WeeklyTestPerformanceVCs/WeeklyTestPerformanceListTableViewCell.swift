//
//  WeeklyTestPerformanceListTableViewCell.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/20/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class WeeklyTestPerformanceListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewRecentTakenWTContentsView: UIView!
    @IBOutlet weak var lblResentlyTakenWT: UILabel!
    @IBOutlet weak var ViewContents: UIView!
    @IBOutlet weak var viewCircular: CircularArc!
    @IBOutlet weak var viewBottomLine: UIView!
    @IBOutlet weak var lblNameTestTaken: UILabel!
    @IBOutlet weak var btnAnalyse: UIButton!
    @IBOutlet weak var btnViewMore: UIButton!
    ///Second Cell OutLates.
    
    @IBOutlet weak var viewSecontsContents: UIView!
    @IBOutlet weak var lblSubjectsName: UILabel!
    @IBOutlet weak var lblShowScore: UILabel!
    @IBOutlet weak var lblShowTarget: UILabel!
    @IBOutlet weak var progressBarKeyFA: UIProgressView!
    @IBOutlet weak var btnMoveToNext: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
  
    
    
}
