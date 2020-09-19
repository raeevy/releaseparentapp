//
//  RecentlyTakenTestWeeklyTestTVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/12/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class RecentlyTakenTestWeeklyTestTVC: UITableViewCell {
    
    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var lblResentlyTaskTest: UILabel!
    @IBOutlet weak var customHeightsContrantsTV: NSLayoutConstraint!
    @IBOutlet weak var xibTableResentlyTT: UITableView! {
        didSet {
            self.xibTableResentlyTT.delegate = self
            self.xibTableResentlyTT.dataSource = self
        }
    }
    
    var parentWeeklyVC:WeeklyTestPerformanceVC?
    var arrResentlyTakenTestCell = NSArray()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.xibTableResentlyTT.estimatedRowHeight = 90
        self.xibTableResentlyTT.rowHeight = UITableView.automaticDimension
        xibTableResentlyTT.register(UINib.init(nibName: "WeeklyRecentlyTakenTestSubXIBTableViewCell", bundle: nil), forCellReuseIdentifier: "WeeklyRecentlyTakenTestSubXIBTableViewCell")
        self.viewContents.shadow(UIView: viewContents)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension RecentlyTakenTestWeeklyTestTVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.arrResentlyTakenTestCell.count <= 3 {
            return self.arrResentlyTakenTestCell.count
        }
        return 3
        //  return self.arrResentlyTakenTestCell.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:WeeklyRecentlyTakenTestSubXIBTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WeeklyRecentlyTakenTestSubXIBTableViewCell") as? WeeklyRecentlyTakenTestSubXIBTableViewCell else { return UITableViewCell() }
        
        cell.parentWeeklyVC = self.parentWeeklyVC
        
        let  dict = arrResentlyTakenTestCell[indexPath.row] as? NSDictionary ?? [:]
        
        let progress = dict.value(forKey: "performance") as? Int ?? 0
        
        let remainSpace = 100 - progress
        var arcArray: [Arc] = [Arc]()
        arcArray.append(Arc(c: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), v: Double(progress)))
        arcArray.append(Arc(c: #colorLiteral(red: 0.5921034217, green: 0.5921911597, blue: 0.592084229, alpha: 1), v: Double(remainSpace ?? 0)))
        cell.viewCircular.Start(array: arcArray, lWidth: 4.0)
        
        
        cell.lblTaskNameShow.text = dict.value(forKey: "test_name") as? String ?? ""
        cell.assignAutoId = dict.value(forKey: "assign_auto_id") as? Int ?? 0
        cell.lblShowPercentage.text = "\(dict.value(forKey: "performance") as? Int ?? 0)%"
        cell.viewUpperCircular.layer.cornerRadius = 30
        cell.viewUpperCircular.layer.borderWidth = 4
        cell.viewUpperCircular.layer.borderColor = UIColor.lightGray.cgColor.copy(alpha: 0.5)
        
        // cell.subNam = dict.value(forKey: "") as? String ?? "
        
        if indexPath.row == arrResentlyTakenTestCell.count - 1 {
            cell.viewBottomLine.isHidden = true
        }
        
        
        return cell
    }
    
    
}
