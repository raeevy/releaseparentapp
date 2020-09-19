//
//  RecentlyTakenTestTVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/8/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class RecentlyTakenTestTVC: UITableViewCell {

    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var lblResentlyTaskTest: UILabel!
    @IBOutlet weak var customHeightsContrantsTV: NSLayoutConstraint!
    @IBOutlet weak var xibTableResentlyTT: UITableView! {
        didSet {
            self.xibTableResentlyTT.delegate = self
            self.xibTableResentlyTT.dataSource = self
        }
    }
    
    var parentVC:SubjectWisePerformanceVC?
    var arrResentlyTakenTestCell = NSArray()
    var subId:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.xibTableResentlyTT.estimatedRowHeight = 90
        self.xibTableResentlyTT.rowHeight = UITableView.automaticDimension
        xibTableResentlyTT.register(UINib.init(nibName: "RecentlyTakenTestXIBCellTVC", bundle: nil), forCellReuseIdentifier: "RecentlyTakenTestXIBCellTVC")
         self.viewContents.shadow(UIView: viewContents)
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension RecentlyTakenTestTVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrResentlyTakenTestCell.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell:RecentlyTakenTestXIBCellTVC = tableView.dequeueReusableCell(withIdentifier: "RecentlyTakenTestXIBCellTVC") as? RecentlyTakenTestXIBCellTVC else { return UITableViewCell() }
        cell.parentVC = self.parentVC
        var  dict = arrResentlyTakenTestCell[indexPath.row] as? NSDictionary ?? [:]
        print("dict is :-", dict)
        let progress = dict.value(forKey: "overall_progress") as? Int ?? 0
        let remainSpace = 100 - progress
        var arcArray: [Arc] = [Arc]()
        arcArray.append(Arc(c: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), v: Double(progress)))
        arcArray.append(Arc(c: #colorLiteral(red: 0.5921034217, green: 0.5921911597, blue: 0.592084229, alpha: 1), v: Double(remainSpace ?? 0)))
        cell.viewCircular.Start(array: arcArray, lWidth: 4.0)
        cell.lblTaskNameShow.text = dict.value(forKey: "chapter_name") as? String ?? ""
        cell.lblShowPercentage.text = "\(dict.value(forKey: "overall_progress") as? Int ?? 0)%"
        cell.viewUpperCircular.layer.cornerRadius = 30
        cell.viewUpperCircular.layer.borderWidth = 4
        cell.viewUpperCircular.layer.borderColor = UIColor.lightGray.cgColor.copy(alpha: 0.5)
        //Hide For Bottom Line.
        if indexPath.row == arrResentlyTakenTestCell.count - 1 {
            cell.viewBottomLine.isHidden = true
        }
        
        cell.dictdata = dict
        
        cell.chapName = dict.value(forKey: "chapter_name") as? String ?? ""
        cell.subjestId = self.subId
        cell.chapterId = dict.value(forKey: "chapter_id") as? String ?? ""
        cell.testId = dict.value(forKey: "test_id") as? String ?? ""
        
    
        
        return cell
    }

}
