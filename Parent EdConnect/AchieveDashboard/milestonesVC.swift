//
//  milestonesVC.swift
//  Parent EdConnect
//
//  Created by Work on 08/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire

class milestonesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    var studentId = UserDefaults.standard.value(forKey: "CHILDID")
    

    @IBOutlet weak var lblcompletedPercentage: UILabel!
    @IBOutlet weak var viewGraphLoader: CircularArc!
    @IBOutlet weak var lblAssignedMileStones: UILabel!
    
    @IBOutlet weak var lblAttempteMilestones: UILabel!
    
    @IBOutlet weak var lblDateTarget: UILabel!
    
    @IBOutlet weak var viewSegments: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnMile1: UIButton!
    @IBOutlet weak var btnMile2: UIButton!
    @IBOutlet weak var btnMile3: UIButton!
    @IBOutlet weak var lblMile1: UILabel!
    @IBOutlet weak var lblMile2: UILabel!
    @IBOutlet weak var lblMile3: UILabel!
    @IBOutlet weak var viewOverallMile: UIView!
    @IBOutlet weak var viewGrapOverallMile: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StatusBarSetup()
        viewSegments.shadow(UIView: viewSegments)
        viewOverallMile.shadow(UIView: viewOverallMile)
        MilestoneListApi()
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
                return .lightContent
          }

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMile1(_ sender: Any) {
        btnMile1.setTitleColor(#colorLiteral(red: 0.14805004, green: 0.3711644709, blue: 0.764950335, alpha: 1), for: .normal)
        lblMile1.backgroundColor = #colorLiteral(red: 0.9449529648, green: 0.5010166168, blue: 0.2282519341, alpha: 1)
        
        lblMile2.backgroundColor = .clear
        btnMile3.backgroundColor = .clear
        
        btnMile2.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        btnMile3.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        
       viewOverallMile.isHidden = false
        tableView.isHidden = false
    }
    
    @IBAction func btnMile2(_ sender: Any) {
        btnMile2.setTitleColor(#colorLiteral(red: 0.14805004, green: 0.3711644709, blue: 0.764950335, alpha: 1), for: .normal)
           lblMile2.backgroundColor = #colorLiteral(red: 0.9449529648, green: 0.5010166168, blue: 0.2282519341, alpha: 1)
        
           lblMile1.backgroundColor = .clear
           lblMile3.backgroundColor = .clear
           
           btnMile1.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
           btnMile3.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        viewOverallMile.isHidden = true
        tableView.isHidden = true
        alert(message: "No Data Found!")
    }
    
    
    
    @IBAction func btnMile3(_ sender: Any) {
        btnMile3.setTitleColor(#colorLiteral(red: 0.14805004, green: 0.3711644709, blue: 0.764950335, alpha: 1), for: .normal)
               lblMile3.backgroundColor = #colorLiteral(red: 0.9449529648, green: 0.5010166168, blue: 0.2282519341, alpha: 1)
               
               lblMile1.backgroundColor = .clear
               lblMile2.backgroundColor = .clear
               
               btnMile1.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
               btnMile2.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        tableView.isHidden = true
        viewOverallMile.isHidden = true
        alert(message: "No Data Found!")
        
    }
    
}


//MARK:- *******-tableViewCycle()-********
//MARK:-
extension milestonesVC {

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 2
   }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "stonesMileTVCell") as! stonesMileTVCell
        cell.viewInsideCell.shadow(UIView: cell.viewInsideCell)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
//        let VC = storyBoard.instantiateViewController(withIdentifier: "personalJReportVC") as! personalJReportVC
//        self.navigationController?.pushViewController(VC, animated: true)
    }
}


//API Number 21-
//
//Api name:
//All Milestone’s List Api
//
//Api Description :
//This api will basically give all milestone’s data of students.
//
//Location where to call:
//When the user clicks on the milestone card in Achieve Dashboard Screen.
//
//Api Type:
//Get
//
//Api URL:
//http://developer.extramarks.com/api/v1.1/subjectwiseprogressreportindo?&board_id=180&class_id=36&is_new_app=1&user_id=67567001&report_type=get_milestone_report_all&parent_id=67567036&apikey=0DEAD50C6BBA59FF22D33C994&checksum=e331fb1a94b856f764a009e7a9571bd4

//
//CheckSum Sequence:
//boardId:classId:isNewApp:studentId:userId:action:parentId:apiKey:salt
//
//isNewApp = 1
//action = get_milestone_report_all
//
//mark:-*************_web_Api_*******
//mark:-
extension milestonesVC {
        func  MilestoneListApi() {
            var Salt = saltMain
            var apiKey = apikeyMain
            var isNewApp = 1
            var action = "get_milestone_report_all"

            var checkSumValues =  "\(BoardId):\(ClassId!):\(isNewApp):\(studentId!):\(UserId!):\(action):\(Salt)"
            
            let myCheckString = MD5(checkSumValues)
      
            print("the chceksum String", checkSumValues)
            print("converted chceksum value ", myCheckString!)
            
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "content-type": "application/json",
            ]
           // 180:36:1:67710419
            
            if Reachability.isConnectedToNetwork() {
                showActivityIndicator()
                AF.request("\(baseUrl)api/v1.1/subjectwiseprogressreportindo?&board_id=180&class_id=36&is_new_app=1&user_id=67567001&report_type=get_milestone_report_all&parent_id=67567036&apikey=0DEAD50C6BBA59FF22D33C994&checksum=e331fb1a94b856f764a009e7a9571bd4", method: .get, encoding: JSONEncoding.default, headers: headers)
                    
                    .responseJSON { (response) in
                        switch response.result {
                        case .success:
                            if let JSON = response.value as? [String: Any]  {
                                
                                self.hideActivityIndicator()
                                print("THE JSON RESULT",JSON)

                                let message = JSON["message"] as? String ?? ""
                                print("the message is",message)
                                //"Milestone 1"
                                
                                if message == "success" {                                      self.hideActivityIndicator()
                                    
//                                    assigned_milestones
                                    
                                    let mainAssignedMilestones = JSON["assigned_milestones"] as? NSArray ?? []

                                    
                                    let milestoneData = JSON["milestone_data"] as? NSDictionary ?? [:]
//                                    print("milestoneData is",milestoneData)
                                    "Milestone 1"
                                    
                                    if milestoneData != nil  {
                                        let milestoneName = milestoneData.value(forKey: "milestone_name") as? String ?? ""
                                        print("milestoneName is",milestoneName)
                                        let overallMilestoneProgress = milestoneData.value(forKey: "overall_milestone_progress") as? NSDictionary ?? [:]
                                        let assignedMilestone = overallMilestoneProgress.value(forKey: "assigned_milestone") as? Int ?? 0
                                        
                                        let attemptedMilestones = overallMilestoneProgress.value(forKey: "attempted_milestones") as? Int ?? 0
                                        
                                        let completedPercentage = overallMilestoneProgress.value(forKey: "completed_percentage") as? Int ?? 0
                                        
                                        let scheduleEndDate = milestoneData.value(forKey: "schedule_end_date") as? String ?? ""
                                        
                                        let scheduleStartDate = milestoneData.value(forKey: "schedule_start_date") as? String ?? ""
                                        
                                        self.lblcompletedPercentage.text = "\(completedPercentage)"
                                        if assignedMilestone != nil && attemptedMilestones != nil {
                                            self.lblAssignedMileStones.text = "\(assignedMilestone) Assigned Milestone"
                                            self.lblAttempteMilestones.text = "\(attemptedMilestones) Attempted Milestone"
                                            var arcArray: [Arc] = [Arc]()
                                            arcArray.append(Arc(c: #colorLiteral(red: 0.9523274302, green: 0.5835757852, blue: 0.2794597745, alpha: 1), v: Double(assignedMilestone)))
                                            arcArray.append(Arc(c: #colorLiteral(red: 0, green: 0.1934992969, blue: 0.7240211964, alpha: 1), v: Double(attemptedMilestones)))
                                            self.viewGraphLoader.Start(array: arcArray, lWidth: 8.0)
                                            
                                        }
                                        let date1 = scheduleStartDate.prefix(10)
                                        let date3 = date1.suffix(5)
                                        let date2 = scheduleEndDate.prefix(10)
                                        self.lblDateTarget.text = "Target: \(date3) to \(date2)"
                                    }
                                    else {
                                        self.alert(message: "No data found!")
                                    }
                                    self.tableView.reloadData()
                                  }
                                else {
                                    var Message = JSON["message"] as? String ?? ""
                                    self.alert(message: Message)
                                }
                            }
                        case .failure(let error):
                            self.hideActivityIndicator()
                            print("ERROR", error.localizedDescription)
                            self.alert(message: error.localizedDescription)
                    }
                }
            }
            else {
                self.hideActivityIndicator()
                alert(message: "No Internet Connection!!")
        
       }
    }
}
