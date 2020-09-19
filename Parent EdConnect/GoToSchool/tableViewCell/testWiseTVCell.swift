//
//  testWiseTVCell.swift
//  Parent EdConnect
//
//  Created by Work on 11/08/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Highcharts

class testWiseTVCell: UITableViewCell {
    @IBOutlet weak var barChartView: HIChartView!
    @IBOutlet weak var viewDiffcultyWiseAnalysis: CustomView!
    @IBOutlet weak var viewGraphLoader: CircularArc!
    @IBOutlet weak var viewReviseChapter: CustomView!
    @IBOutlet weak var lblChapterName: UILabel!
    @IBOutlet weak var lblIdeleAndTakenTime: UILabel!
    
    @IBOutlet weak var lblPercentage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
