//
//  subjectAttemptedVC.swift
//  Parent EdConnect
//
//  Created by Work on 06/08/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.



import UIKit

//- Attempted Array from API 42, 44, 46

class subjectAttemptedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var attemptScreen:Int?
    var screenName2:String?
    var arrAttempted1 = NSArray()
    
    @IBOutlet weak var lblScreenName: UILabel!
    @IBOutlet weak var dataTable: UITableView!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var viewSegment: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnFilter.gradientYellow()
        StatusBarSetup()
        viewSegment.layer.borderColor =  #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        viewSegment.layer.borderWidth = 1.0
        print("arrAttempted1 is",arrAttempted1)
    }
    override func viewWillAppear(_ animated: Bool) {
        if screenName2 != nil {
            lblScreenName.text = screenName2!
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.backToViewController(viewController: worksheetHomeworkWeeklyOverviewVC.self)
    }
    
    @IBAction func btnAssigned(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        //        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        //        let VC = storyBord.instantiateViewController(withIdentifier: "subjectAssignedVC") as! subjectAssignedVC
        //        VC.assignScreen = attemptScreen
        //        self.navigationController?.pushViewController(VC, animated: false)
    }
    
    @IBAction func btnFilter(_ sender: Any) {
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "filterVC") as! filterVC
        self.navigationController?.pushViewController(VC, animated: false)
    }
}

//MARK:- ******_TableView_Cycle_**********
//MARK:-
extension subjectAttemptedVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAttempted1.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectAttemptedTVCell") as! subjectAttemptedTVCell
        
        let dict = arrAttempted1[indexPath.row] as? NSDictionary ?? [:]
        let title = dict.value(forKey: "title") as? String ?? ""
        let assignDate = dict.value(forKey: "assign_date") as? String ?? ""
        let attemptedState = dict.value(forKey: "attempted_state") as? String ?? ""
        let attemptStatusId = dict.value(forKey: "attempt_status_id") as? String ?? ""
        
        
        
        // "attempted_state": "" = "assigned"
        // "attempted_state": "1" OR "2" = "attempted"
        // "attempted_state": "3" = "evaluate"(show analyse)
        
        if attemptedState == "3" || attemptStatusId == "3" {
            print("in 3 attemptedState")

            cell.btnAnalyse.isHidden = false
            cell.tapAnalyse.isHidden = false
            cell.lblUnderEvaluation.isHidden = true
        }
            
        else  if attemptedState == "1" || attemptStatusId == "1" || attemptedState == "2" || attemptStatusId == "2" ||  attemptedState == "" || attemptStatusId == "" {
            
             print("in 1, 2 attemptedState")
            cell.btnAnalyse.isHidden = true
            cell.tapAnalyse.isHidden = true
            cell.lblUnderEvaluation.isHidden = false
        }
    
//
//        print("attemptedState is",attemptedState)
        print("attemptStatusId is",attemptStatusId)
//
//
        let assignDate1 = Int(assignDate) ?? 0
        
        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(assignDate1)/1000)
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateStyle = .medium
        let dateIs = dateFormatter.string(from: dateVar)
        
        dateFormatter.dateFormat = "HH:mm a"
        let timeIs = dateFormatter.string(from: dateVar)
        
        cell.lblTitle.text = title
        cell.lblDate.text = "Attempted Date: \(dateIs)"
        cell.lblTime.text = "Attempted Time: \(timeIs)"
        
        cell.viewInsidCell.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        cell.viewInsidCell.cornerRadius = 10
        cell.viewInsidCell.borderWidth = 2

        cell.btnAnalyse.cropMskToBund()
        cell.btnAnalyse.gradientYellow()
        
        cell.tapAnalyse.addTarget(self, action: #selector(tapAnalyseClicked(_:)), for: .touchUpInside)
        cell.tapAnalyse.tag = indexPath.row

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
  @objc func tapAnalyseClicked(_ sender:UIButton){
         
    let btn = sender
    let indexP = NSIndexPath(item: btn.tag, section: 0)
    let cell = dataTable.dequeueReusableCell(withIdentifier: "subjectAttemptedTVCell", for: indexP as IndexPath) as! subjectAttemptedTVCell
    
    if attemptScreen == 3 {

        let dict = self.arrAttempted1.object(at: indexP.row) as? NSDictionary ?? [:]
        let assign_auto_id = dict.value(forKey: "assign_auto_id") as? String ?? ""
        let storyBoard : UIStoryboard = UIStoryboard(name: "GoToSchool", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "testWiseAnlysis") as! testWiseAnlysis
        VC.ansScreencheck = 3
        VC.autoID = assign_auto_id
        self.navigationController?.pushViewController(VC, animated: true)
    }
    else  if attemptScreen == 1 {
        let dict = self.arrAttempted1.object(at: indexP.row) as? NSDictionary ?? [:]
        let assign_auto_id = dict.value(forKey: "assign_auto_id") as? String ?? ""
        let storyBoard : UIStoryboard = UIStoryboard(name: "GoToSchool", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "answerKeyGtsVC") as! answerKeyGtsVC
        VC.screenCheck = 1
        VC.weeklytestId = assign_auto_id
        self.navigationController?.pushViewController(VC, animated: true)
    }
        
    else  if attemptScreen == 2 {
        let dict = self.arrAttempted1.object(at: indexP.row) as? NSDictionary ?? [:]
        let storyBoard : UIStoryboard = UIStoryboard(name: "GoToSchool", bundle:nil)
        let assign_auto_id = dict.value(forKey: "assign_auto_id") as? String ?? ""
        let VC = storyBoard.instantiateViewController(withIdentifier: "answerKeyGtsVC") as! answerKeyGtsVC
        VC.screenCheck = 2
        VC.weeklytestId = assign_auto_id
        self.navigationController?.pushViewController(VC, animated: true)
    }
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if attemptScreen == 3 {
//            let dict = arrAttempted1[indexPath.row] as? NSDictionary ?? [:]
//            let assign_auto_id = dict.value(forKey: "assign_auto_id") as? String ?? ""
//            let storyBoard : UIStoryboard = UIStoryboard(name: "GoToSchool", bundle:nil)
//            let VC = storyBoard.instantiateViewController(withIdentifier: "testWiseAnlysis") as! testWiseAnlysis
//            VC.ansScreencheck = 3
//            VC.autoID = assign_auto_id
//            self.navigationController?.pushViewController(VC, animated: true)
//        }
//        else  if attemptScreen == 1 {
//
//            let dict = arrAttempted1[indexPath.row] as? NSDictionary ?? [:]
//            let assign_auto_id = dict.value(forKey: "assign_auto_id") as? String ?? ""
//            let storyBoard : UIStoryboard = UIStoryboard(name: "GoToSchool", bundle:nil)
//            let VC = storyBoard.instantiateViewController(withIdentifier: "answerKeyGtsVC") as! answerKeyGtsVC
//            VC.screenCheck = 1
//            VC.weeklytestId = assign_auto_id
//            self.navigationController?.pushViewController(VC, animated: true)
//        }
//
//        else  if attemptScreen == 2 {
//            let dict = arrAttempted1[indexPath.row] as? NSDictionary ?? [:]
//            let storyBoard : UIStoryboard = UIStoryboard(name: "GoToSchool", bundle:nil)
//            let assign_auto_id = dict.value(forKey: "assign_auto_id") as? String ?? ""
//            let VC = storyBoard.instantiateViewController(withIdentifier: "answerKeyGtsVC") as! answerKeyGtsVC
//            VC.screenCheck = 2
//            VC.weeklytestId = assign_auto_id
//            self.navigationController?.pushViewController(VC, animated: true)
//        }
    }
}

