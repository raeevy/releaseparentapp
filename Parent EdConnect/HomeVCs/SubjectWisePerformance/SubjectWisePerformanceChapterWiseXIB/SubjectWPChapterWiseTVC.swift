//
//  SubjectWPChapterWiseTVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/8/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class SubjectWPChapterWiseTVC: UITableViewCell {

    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblChapterWise: UILabel!
    @IBOutlet weak var viewCoverage: UIView!
    @IBOutlet weak var lblCoverage: UILabel!
    @IBOutlet weak var viewPerformance: UIView!
    @IBOutlet weak var lblPerformanceCWP: UILabel!
    
    @IBOutlet weak var customHeightConstrantCWP: NSLayoutConstraint!
    @IBOutlet weak var chapterWiseSubXIBCell: UITableView! {
        didSet {
            self.chapterWiseSubXIBCell.delegate = self
            self.chapterWiseSubXIBCell.dataSource = self
        }
    }
    
    var arrChapterWisePerformanceCell = NSArray()
    var parentVC:SubjectWisePerformanceVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.chapterWiseSubXIBCell.estimatedRowHeight = 110
        self.chapterWiseSubXIBCell.rowHeight = UITableView.automaticDimension
        chapterWiseSubXIBCell.register(UINib.init(nibName: "SubjectWPChapterWiseSubXIBTVC", bundle: nil), forCellReuseIdentifier: "SubjectWPChapterWiseSubXIBTVC")
        self.setupView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        self.viewContent.shadow(UIView: viewContent)
        self.viewCoverage.layer.cornerRadius = 5
        self.viewPerformance.layer.cornerRadius = 5
    }
}

extension SubjectWPChapterWiseTVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrChapterWisePerformanceCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell:SubjectWPChapterWiseSubXIBTVC = tableView.dequeueReusableCell(withIdentifier: "SubjectWPChapterWiseSubXIBTVC") as? SubjectWPChapterWiseSubXIBTVC else { return UITableViewCell() }
        cell.parentVC = self.parentVC
        let dictChap = self.arrChapterWisePerformanceCell[indexPath.row] as? NSDictionary ?? [:]
        let performanceP = dictChap.value(forKey: "performance") as? Double ?? 0.0
        let coverageP = dictChap.value(forKey: "coverage") as? Double ?? 0.0
        
        let max = 100.0
        let progressValue =  performanceP / 100.0
        cell.blueProgreshBarAvragePercentage.setProgress(Float(progressValue), animated: false)
        
        let maxYello = 100.0
        let progressValueYello =  coverageP / 100.0
        cell.yelloFullPercentageProgressBar.setProgress(Float(progressValueYello), animated: false)
        
        cell.lblBlueAvrageShowPercentage.text = "\(performanceP)"
        cell.lblYelloFullShowPercentage.text = "\(coverageP)"
        cell.lblChapterName.text = dictChap.value(forKey: "chapter_name") as? String ?? ""

        return cell
    }


}
