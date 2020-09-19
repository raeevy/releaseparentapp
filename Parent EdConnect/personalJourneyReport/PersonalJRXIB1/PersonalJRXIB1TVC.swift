//
//  PersonalJRXIB1TVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 9/2/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class PersonalJRXIB1TVC: UITableViewCell {
    
    @IBOutlet weak var viewCustomLine: UIView!
    @IBOutlet weak var viewContenst: UIView!
    @IBOutlet weak var customHeightsTV: NSLayoutConstraint!
    
    //    @IBOutlet weak var viewUpperContents: UIView!
    //    @IBOutlet weak var upperDtaXIBtable2: UITableView!{
    //        didSet {
    //            self.upperDtaXIBtable2.delegate = self
    //            self.upperDtaXIBtable2.dataSource = self
    //        }
    //    }
    @IBOutlet weak var xibTableView: UITableView! {
        didSet {
            self.xibTableView.delegate = self
            self.xibTableView.dataSource = self
        }
    }
    
    
    var arrTestDetail = NSArray()
    var parentVC:personalJReportVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // self.xibTableView.estimatedRowHeight = 75
        self.xibTableView.rowHeight = UITableView.automaticDimension
        self.xibTableView.register(UINib(nibName: "PersonalJRXib2TVC", bundle: nil), forCellReuseIdentifier: "PersonalJRXib2TVC")
        
//        self.viewCustomLine.layer.borderWidth = 1
//        self.viewCustomLine.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//      //  self.viewContenst.shadow(UIView: self.viewContenst)
        
        self.viewContenst.layer.cornerRadius = 10
        self.viewContenst.layer.borderWidth = 1
        self.viewContenst.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension PersonalJRXIB1TVC :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrTestDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell:PersonalJRXib2TVC = tableView.dequeueReusableCell(withIdentifier: "PersonalJRXib2TVC") as? PersonalJRXib2TVC else { return UITableViewCell() }
        
        let arrTestDetailDict = self.arrTestDetail[indexPath.row] as? NSDictionary ?? [:]
        cell.lblConceptName.text = arrTestDetailDict.value(forKey: "concept_name") as? String ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = arrTestDetail[indexPath.row] as? NSDictionary ?? [:]
        let score = dict.value(forKey: "score") as? String ?? ""
        let userLevel = dict.value(forKey: "user_level") as? String ?? ""
        let userMessage = dict.value(forKey: "user_message") as? String ?? ""
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "evaluatedWorksheetVC") as! evaluatedWorksheetVC
        VC.score = score
        //VC.userLevel = userLevel
        VC.UserMessage = userMessage
        self.parentVC?.navigationController?.pushViewController(VC, animated: true)
        
    }
    
}
