//
//  subjectAssignedVC.swift
//  Parent EdConnect
//
//  Created by Work on 06/08/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire
//API:42- worksheet >  subject = assign, attempted
//API:44- homework >  subject = assign, attempted
//API:46- weekly-test > subject = assign,  attempted


// "attempted_state": "" = "assigned"
// "attempted_state": "1" OR "2" = "attempted"
// "attempted_state": "3" = "evaluate"(show analyse)

class subjectAssignedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var assignVCCheck:Int?
    var screenName:String?
    var subId:String?
    var servIdInApi:Int?
    var videoCategory:String?
    
    var arrAssigned = NSArray()
    var arrAttempted = NSArray()
    
    var arrAssigned2 = NSMutableArray()
    var arrAttempted2 = NSMutableArray()
    
    var arrAssigned3 = NSMutableArray()
    var arrAttempted3 = NSMutableArray()
    
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    var schoolID = UserDefaults.standard.value(forKey: "SCHOOLID")
    var section = UserDefaults.standard.value(forKey: "SECTION")
    var sectionID = UserDefaults.standard.value(forKey: "SECTIONID")
    var vidoeCategory = UserDefaults.standard.value(forKey: "VIDEOCATEGORY")

    
    @IBOutlet weak var lblScreenName: UILabel!
    @IBOutlet weak var lblTotalAssigned: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var viewSegment: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnFilter.gradientYellow()
        StatusBarSetup()
        
        viewSegment.layer.borderColor =  #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        viewSegment.layer.borderWidth = 1.5
        
        if assignVCCheck == 1 {
            API42()
        } else if assignVCCheck == 2 {
            API44()
             
        } else if assignVCCheck == 3 {
            API46()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if screenName != nil {
            lblScreenName.text = screenName!
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.backToViewController(viewController: worksheetHomeworkWeeklyOverviewVC.self)
    }
    
    @IBAction func btnAttempted(_ sender: Any) {
        
        if assignVCCheck == 1 {
            //API42()
            let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
            let VC = storyBord.instantiateViewController(withIdentifier: "subjectAttemptedVC") as! subjectAttemptedVC
            VC.attemptScreen = assignVCCheck
            VC.arrAttempted1 = self.arrAttempted
            VC.screenName2 = screenName
            self.navigationController?.pushViewController(VC, animated: false)
            
        } else if assignVCCheck == 2 {
            //API44()
            let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
            let VC = storyBord.instantiateViewController(withIdentifier: "subjectAttemptedVC") as! subjectAttemptedVC
            VC.attemptScreen = assignVCCheck
            VC.arrAttempted1 = self.arrAttempted3
            VC.screenName2 = screenName
            self.navigationController?.pushViewController(VC, animated: false)
            
        } else if assignVCCheck == 3 {
            //API46()
            let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
            let VC = storyBord.instantiateViewController(withIdentifier: "subjectAttemptedVC") as! subjectAttemptedVC
            VC.attemptScreen = assignVCCheck
            VC.arrAttempted1 = self.arrAttempted2
            VC.screenName2 = screenName
            self.navigationController?.pushViewController(VC, animated: false)
            
        }
    }
    
    @IBAction func btnFilter(_ sender: Any) {
        
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "filterVC") as! filterVC
        self.navigationController?.pushViewController(VC, animated: false)
        
        //        let filterVC = self.storyboard?.instantiateViewController(withIdentifier: "filterVC") as! filterVC
        //        self.present(filterVC, animated: true, completion: nil)
    }
}

//MARK:- ******_TableView_Cycle_**********
//MARK:-
extension subjectAssignedVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if assignVCCheck == 1 {
            // API42()
            print("the count 1",arrAssigned.count)
            return arrAssigned.count
        } else if assignVCCheck == 2 {
            //API44()
             print("the count 2",arrAssigned.count)
            return arrAssigned3.count
        } else  {
            //API46()
             print("the count 3",arrAssigned2.count)
            return arrAssigned2.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectAssignedTVCell") as! subjectAssignedTVCell
        
       // let dict = arrAssigned[indexPath.row] as? NSDictionary ?? [:]
        
        if assignVCCheck == 1 {
            let dict = arrAssigned[indexPath.row] as? NSDictionary ?? [:]
                   //API42()
            let title = dict.value(forKey: "title") as? String ?? ""
            let assignDate = dict.value(forKey: "assign_date") as? String ?? ""
            
            let assignDate1 = Int(assignDate) ?? 0
            
            let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(assignDate1)/1000)
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.dateStyle = .medium
            let dateIs = dateFormatter.string(from: dateVar)
            
            dateFormatter.dateFormat = "HH:mm a"
            let timeIs = dateFormatter.string(from: dateVar)
            
            cell.lblTitle.text = title
            cell.lblAttemptedDate.text = "Attempted Date: \(dateIs)"
            cell.lblAttemptedTime.text = "Attempted Time: \(timeIs)"
            
               } else if assignVCCheck == 2 {
                   //API44()
            let dict = arrAssigned3[indexPath.row] as? NSDictionary ?? [:]
                   //API42()
            let title = dict.value(forKey: "title") as? String ?? ""
            let assignDate = dict.value(forKey: "assign_date") as? String ?? ""
            
            let assignDate1 = Int(assignDate) ?? 0
            
            let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(assignDate1)/1000)
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.dateStyle = .medium
            let dateIs = dateFormatter.string(from: dateVar)
            
            dateFormatter.dateFormat = "HH:mm a"
            let timeIs = dateFormatter.string(from: dateVar)
            
            cell.lblTitle.text = title
            cell.lblAttemptedDate.text = "Attempted Date: \(dateIs)"
            cell.lblAttemptedTime.text = "Attempted Time: \(timeIs)"
            
               } else if assignVCCheck == 3 {
                   //API46()
            let dict = arrAssigned2[indexPath.row] as? NSDictionary ?? [:]
            
            let paperName = dict.value(forKey: "paper_name") as? String ?? ""
            let assignDate = dict.value(forKey: "paper_start_time") as? String ?? ""
                        
            cell.lblTitle.text = paperName
            cell.lblAttemptedDate.text = "Attempted Date: \(assignDate.prefix(10))"
            cell.lblAttemptedTime.text = "Attempted Time: \(assignDate.suffix(8))"
      
               }
        
        // "attempted_state": "" = "assigned"
        // "attempted_state": "1" OR "2" = "attempted"
        // "attempted_state": "3" = "evaluate"(show analyse)
      
        cell.viewInsideCell.clipsToBounds = true
        cell.viewInsideCell.layer.cornerRadius = 10.0
        cell.viewInsideCell.layer.borderColor =  #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        cell.viewInsideCell.layer.borderWidth = 1.0
        return cell
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


// On click of  worksheet subjects
//MARK:- *****_WEB_API_CALL_******
//mark:-  ****_API:42
extension subjectAssignedVC {
    func API42() {
        
        let StudentType = "2"
        let Action = "worksheet_homework_details_v2"
        
        let checkSumValues =  "\(UserId!):\(StudentType):\(BoardId!):\(ClassId!):\(Action):\(servIdInApi!):\(subId!):\(saltMainLMS):\(apikeyMainLMS)"
        
        var uparcaseChecksum = checkSumValues.uppercased()
        let myCheckString = MD5(uparcaseChecksum)
        
        let postData = [
            "student_id": UserId,
            "student_type": StudentType,
            "board_id": BoardId,
            "class_id": ClassId,
            "school_id": schoolID,
            "section_id": sectionID,
            "section_name": section,
            "video_category": vidoeCategory, //(gts = 1), (sah ="")
            "is_custom_rack": "0", //(gts = 0), (sah =0)
            "action": Action,
            "service_id": servIdInApi, //(service_id) api 38
            "rack_id": subId, //(subject_id) api 38
            "timezone": "Asia/Kolkata",
            "checksum": myCheckString
            ] as [String : Any]
        
        
        
        print("subId is",subId)
                
        print("the chceksum String", checkSumValues)
        print("converted chceksum MD5 value ", myCheckString!)
        print("postData is",postData)
        print("vidoeCategory is",vidoeCategory)


        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("http://stagelearning.extramarks.com/school_lms/public/api/v1.0/weeklyv2", method: .post, parameters: postData, encoding: JSONEncoding.default )
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                            print("THE JSON RESULT 42",JSON)
                            let Status = JSON["response_code"] as? Int ?? 0
                            print("the status is",Status)
                            let status = JSON["status"] as? String ?? ""
                            print("the status is ",status)
                            
                            if status == "1" {
                                
                                self.arrAssigned = JSON["assigned"] as? NSArray ?? []
                                self.arrAttempted = JSON["attempted"] as? NSArray ?? []
                                self.lblTotalAssigned.text = "Total Assigned: \(self.arrAssigned.count)"
                                print("self.arrAssigned 42 is",self.arrAssigned)
                                print("self.arrAttempted 42 is",self.arrAttempted)
                                print("self.arrAttempted.count 42 is",self.arrAssigned.count)
                            }
                            self.tableView.reloadData()
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

// On click of  homework subjects
//MARK:- *****_WEB_API_CALL_******
//mark:-  ****_API:44
extension subjectAssignedVC {
    func API44() {
        let StudentType = "2"
        let Action = "homework_details_v2_school"
        
        let checkSumValues =  "\(UserId!):\(StudentType):\(BoardId!):\(ClassId!):\(Action):\(servIdInApi!):\(subId!):\(saltMainLMS):\(apikeyMainLMS)"
        
        var uparcaseChecksum = checkSumValues.uppercased()
        
        let myCheckString = MD5(uparcaseChecksum)
        
        print("subId is",subId)
        
        let postData = [
            "school_id": schoolID,
            "section_id": sectionID,
            "section_name": section,
            "student_id": UserId,
            "student_type": StudentType,
            "board_id": BoardId,
            "class_id": ClassId,
            "action": Action,
            "service_id": servIdInApi,
            "subject_id": subId,
            "is_custom_rack": "0", //statis
            "video_category":vidoeCategory,
            "checksum": myCheckString
            ] as [String : Any]
        
        print("the chceksum String", checkSumValues)
        print("converted chceksum MD5 value ", myCheckString!)
        print("postData is",postData)
        print("vidoeCategory is",vidoeCategory)
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("http://stagelearning.extramarks.com/school_lms/public/api/v1.0/weeklyv2", method: .post, parameters: postData, encoding: JSONEncoding.default )
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                            print("THE JSON RESULT 44",JSON)
                            let Status = JSON["response_code"] as? Int ?? 0
                            print("the status is",Status)
                            let status = JSON["status"] as? String ?? ""
                            print("the status is ",status)
                            
                            if status == "1" {
                                
                                let arrSubject = JSON["subject"] as? NSArray ?? []
                                let arrHomework = arrSubject.value(forKey: "homework") as? NSArray ?? []
                                
                                
                                print("arrHomework is",arrHomework)
                                print("arrHomework count is",arrHomework.count)
                                
                                if arrHomework.count != 0 {
                                     let arrHomework2 = arrHomework.object(at: 0) as? NSArray ?? []
                                    print("arrHomework2 in 44",arrHomework2)
                                    
                                    if arrHomework2 != nil {
                                        for (index, element) in arrHomework2.enumerated() {
                                            let dataDict = arrHomework2.object(at: index) as? NSDictionary ?? [:]
                                            
                                            print("dataDict in 44",dataDict)
                                            let attemptStatus = dataDict.value(forKey: "attempted_state") as? Any ?? ""
                                            
                                            print("attemptStatus  in 44 is",attemptStatus)
                                         
                                            if attemptStatus as! String == "3" || attemptStatus as! String == "2" || attemptStatus as! String == "1" {
                                                self.arrAttempted3.add(element)
                                            }
                                            else if attemptStatus as! String == "" {
                                                self.arrAssigned3.add(element)
                                            }
                                            
                                            print("arrAttempted3 in 44",self.arrAttempted3)
                                            print("arrAssigned3 in 44",self.arrAssigned3)
                                        }
                                    }
                                    print("arrAttempted3 in 44",self.arrAttempted3)
                                    print("arrAssigned3 in 44",self.arrAssigned3)
                                    
                                    print("arrAttempted3 count in 44",self.arrAttempted3.count)
                                    print("arrAssigned3 count 44",self.arrAssigned3.count)
                                }
                                
                                self.lblTotalAssigned.text = "Total assigned:  \(self.arrAssigned3.count)"
                           
//                                self.arrAssigned = JSON["assigned"] as? NSMutableArray ?? []
//                                self.arrAttempted = JSON["attempted"] as? NSMutableArray ?? []
//
//                                //"attempted_state"
//
//                                self.lblTotalAssigned.text = "Total Assigned: \(self.arrAssigned.count)"
//                                print("self.arrAssigned 44 is",self.arrAssigned)
//                                print("self.arrAttempted 44 is",self.arrAttempted)
                            }
                            self.tableView.reloadData()
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

// On click of  weekely test subjects
//MARK:- *****_WEB_API_CALL_******
//mark:-  ****_API:44
extension subjectAssignedVC {
    func API46() {
        
        let StudentType = "2"
        let Action = "school_previous_paper_list"
        let paperType = "10"
        
    // userId :student_type:board_id:class_id :action:paperType:subid :Salt:API_key

        let checkSumValues =  "\(UserId!):\(StudentType):\(BoardId!):\(ClassId!):\(Action):\(paperType):\(subId!):\(saltMainLMS):\(apikeyMainLMS)"
        
        var uparcaseChecksum = checkSumValues.uppercased()
        let myCheckString = MD5(uparcaseChecksum)
        
        let postData = [
            "user_id": UserId,
            "student_type": StudentType,
            "board_id": BoardId,
            "class_id": ClassId,
            "action": Action,
            "school_id": schoolID,
            "section_id": sectionID,
            "section_name": section,
            "paper_type": "10",
            "subject_id": subId,
            "checksum": myCheckString
            ] as [String : Any]
        
        print("the chceksum String", checkSumValues)
        print("converted chceksum MD5 value ", myCheckString!)
        print("postData is",postData)
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("http://stagelearning.extramarks.com/school_lms/public/api/v1.0/weeklyv2", method: .post, parameters: postData, encoding: JSONEncoding.default )
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                            print("THE JSON RESULT 46",JSON)
                            let Status = JSON["response_code"] as? Int ?? 0
                            print("the status is",Status)
                            let status = JSON["status"] as? String ?? ""
                            print("the status is ",status)
                            
                            if status == "1" {
                                let arrPreviousTest = JSON["previous_test"] as? NSArray ?? []
                                
                                if arrPreviousTest != nil || arrPreviousTest.count != 0 {
                                    
                                    for (index, element) in arrPreviousTest.enumerated() {
                                        let dataDict = arrPreviousTest.object(at: index) as? NSDictionary ?? [:]
                                        
                                        let attemptStatus = dataDict.value(forKey: "attempt_status") as? String ?? ""
                                        
                                        if attemptStatus == "Attempted" {
                                            self.arrAttempted2.add(element)
                                        }
                                        else if attemptStatus == "Not Attempted" {
                                            self.arrAssigned2.add(element)
                                        }
                                    }
                                    
                                    self.lblTotalAssigned.text = "Total Assigned: \(self.arrAssigned2.count)"
                                    
                                    print("self.arrAssigned 46 is",self.arrAssigned)
                                    print("self.arrAttempted 46 is",self.arrAttempted)
                                    print("arrAssigned.count is",self.arrAssigned2.count)
                                }
                            }
                            self.tableView.reloadData()
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

//homework
// "attempted_state": "2" = "attempted" (undevaluate)
// "attempted_state": "1" = "assigned"
// "attempted_state": "3" = "evaluate"(show analyse)

// "attempted_state": "" = "" (assigned)

//empty
//
//0 assigned
//2, 3 //



