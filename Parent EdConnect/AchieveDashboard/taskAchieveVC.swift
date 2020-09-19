//
//  taskAchieveVC.swift
//  Parent EdConnect
//
//  Created by Work on 08/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire


class taskAchieveVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var taskType:String?
    var arrAssignments = NSArray()
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    var name = UserDefaults.standard.value(forKey: "NAME")
    var studentId = UserDefaults.standard.value(forKey: "CHILDID")
    var email = UserDefaults.standard.value(forKey: "EMAIL")
    var mobileNo = UserDefaults.standard.value(forKey: "MOBILE")
    
    @IBOutlet weak var lblScreenName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StatusBarSetup()
        if  UserId != nil  && studentId !=  nil && BoardId != nil && ClassId != nil {
            assignedPendingTaskApi()
        }
        
        print("userId is",UserId)
        print("studentId is",studentId)
        print("BoardId is",BoardId)
        print("ClassId is",ClassId)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if taskType == "01" {
            lblScreenName.text = "Assigned Task"
        }
        else if taskType == "02" {
            lblScreenName.text = "Pending Task"
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//Mark:- *********_TableView_Cycle_***********
//Mark:-
extension taskAchieveVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAssignments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskAchieveTVCell") as! taskAchieveTVCell
        
        let dict = self.arrAssignments[indexPath.row] as? NSDictionary ?? [:]
        let subjectName = dict.value(forKey: "subject_name") as? String ?? ""
        let assignDate = dict.value(forKey: "assign_date") as? String ?? ""
        let endDate = dict.value(forKey: "end_date") as? String ?? ""
        
        cell.lblSubjectName.text = subjectName
        cell.lblStartDate.text = assignDate
        cell.lblEndDate.text = endDate
        cell.viewCell.shadow(UIView: cell.viewCell)
        cell.btnDownload.gradientYellow()
        cell.btnDownload.cropMskToBund()
        return cell
    }
    //MARK:- ******_heightForRow_table_view*****
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
    //MARK:- ******_didSelectRowAt_table_view*****
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//
//API Number 23-
//
//Api Name:
//Assigned/Pending Task
//
//Api Description :
//This api will basically give the data of assigned task and pending task for Achieve Dashboard
//
//Api Url:
//http://lmstest.emscc.extramarks.com/school_lms/public/api/v1.0/weeklyv2
//
//Api Type:
//Post
//
//Location where to call:
//When user click on Assigned/Pending Task card in Achieve Dashboard Screen
//
//Post Data:
//
//{"user_id":"67567001","student_type":"2","board_id":"180","class_id":"36","action":"mentor_assigned_task","language_code":"01","task_type":"02","user_subject_list":"177,176,171,182,557202,206,203,310768,214","checksum":"46cd528f122ee8809e6514556c2a5e16"}
//
//CheckSum Sequence:
//userId  :  + studnet_type  : boardId :  classId : action   : assignment_type : SALT   : API KEY
//
//CheckSum and Post data Parameter Values:
//
//action = mentor_assigned_task
//task_type =( 01 for Assigned Task, 02 for Pending Task)
//apiKey = 8FF8508F917BCC12FFDCD
//salt = "EF6C40ECBA";
//User_subject_list = Please refer to API number 24 for this
//
//Note:Please first convert checksum string to upper case then pass to MD5 Algo.


//MARK:- *****_WEB_API_CALL_******
//mark:-  ****_API: 23
extension taskAchieveVC {
        func assignedPendingTaskApi() {
            
            print("taskType is",taskType)
            
            var action = "mentor_assigned_task"
            var studentType = "2"
            var apiKey = apikeyMain
            var salt = saltMain
            
            var checkSum =  "\(UserId!):\("2"):\(BoardId!):\(ClassId!):\(action):\(taskType!):\(salt):\(apiKey)"
            
            var uparcaseChecksum = checkSum.uppercased()
            let myChecksum = MD5(uparcaseChecksum)

            
            let postData = [
                "user_id":"67567001",
                "student_type":"2",
                "board_id":"180",
                "class_id":"36",
                "action":"mentor_assigned_task",
                "language_code":"01",
                "task_type":taskType,
                "user_subject_list":"177,176,171,182,557202,206,203,310768,214",
                "checksum":"46cd528f122ee8809e6514556c2a5e16"
                ] as [String : Any]
            
            print("the chceksum String", checkSum)
            print("uparcaseChecksum is",uparcaseChecksum)
            print("converted chceksum MD5 value ", myChecksum!)
            print("postData is",postData)
            
            if Reachability.isConnectedToNetwork() {
               showActivityIndicator()
                AF.request("\(baseUrl)school_lms/public/api/v1.0/weeklyv2", method: .post, parameters: postData, encoding: JSONEncoding.default )
                    .responseJSON { (response) in
                        switch response.result {
                        case .success:
                            if let JSON = response.value as? [String: Any]  {
                                self.hideActivityIndicator()
                                print("THE JSON RESULT",JSON)
                               let Status = JSON["response_code"] as? Int ?? 0
                                print("the status is",Status)
                                let status = JSON["status"] as? String ?? ""
                                print("the status is ",status)
                                
                                if status   == "1" {
                                    self.arrAssignments = JSON["assignments"] as? NSArray ?? []
                                    print("assignments",self.arrAssignments)
                                    
                                }
                                if self.arrAssignments.count ==  0 {
                                    self.alert(message: "No Data Found!")
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
