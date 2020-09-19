//
//  WeeklyRecentlyTakenTestSubXIBTableViewCell.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/12/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class WeeklyRecentlyTakenTestSubXIBTableViewCell: UITableViewCell {

    @IBOutlet weak var viewUpperCircular: UIView!
    @IBOutlet weak var lblTaskNameShow: UILabel!
    @IBOutlet weak var btnAnalyse: UIButton!
    @IBOutlet weak var viewBottomLine: UIView!
    @IBOutlet weak var lblShowPercentage: UILabel!
    @IBOutlet weak var viewCircular: CircularArc!
    
    var parentWeeklyVC:WeeklyTestPerformanceVC?
    var subNam:String?
    var assignAutoId:Int?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        
        self.btnAnalyse.gradientYellow()
        self.btnAnalyse.cornerRadius()
    }
    
    @IBAction func didTapAnalizeBtn(_ sender: UIButton) {
            let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
            let VC = storyBord.instantiateViewController(withIdentifier: "testWiseAnlysis") as! testWiseAnlysis
             VC.ansScreencheck = 2
            VC.weeklyTestID = self.assignAutoId
            self.parentWeeklyVC?.navigationController?.pushViewController(VC, animated: true)
    }
    
}
