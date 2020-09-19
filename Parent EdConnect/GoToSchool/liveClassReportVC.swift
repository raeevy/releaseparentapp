//
//  liveClassReportVC.swift
//  Parent EdConnect
//
//  Created by Work on 28/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
//API:39
class liveClassReportVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrSessionList = NSArray()
    
    @IBOutlet weak var lblTotalLecture: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBarSetup()
        API39()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "VIDEOCATEGORY")
               self.navigationController?.backToViewController(viewController: goToSchoolReportVC.self)
    }
    
    @IBAction func btnCalender(_ sender: Any) {
    }
    
    @IBAction func btnFilter(_ sender: Any) {
    }
    
}

//MARK:- ************_TableViewCycle_**********
//MARK:-

extension liveClassReportVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count is",arrSessionList.count)
        return arrSessionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "liveClassReportTVCell") as! liveClassReportTVCell
        let dict = arrSessionList[indexPath.row] as? NSDictionary ?? [:]
        
        let suject_name = dict.value(forKey: "suject_name") as? String ?? ""
        let faculty_name = dict.value(forKey: "faculty_name") as? String ?? ""
        let session_date = dict.value(forKey: "session_date") as? String ?? ""
        let suject_icon = dict.value(forKey: "suject_icon") as? String ?? ""
        let attended = dict.value(forKey: "attended") as? Int ?? 0
        
        cell.lblSubName.text = suject_name
        cell.lblFacultyName.text = "\(faculty_name)"
        cell.lblSessionDate.text = String(session_date.prefix(10))
        
        cell.imgSubIcon.sd_setImage(with: URL(string: suject_icon))
        cell.imgSubIcon.layer.cornerRadius = cell.imgSubIcon.frame.size.width / 2
        cell.imgSubIcon.clipsToBounds = true
        
        cell.viewInsideCell.clipsToBounds = true
        cell.viewInsideCell.layer.cornerRadius = 10.0
        
        if attended == 0 {
            cell.viewInsideCell.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cell.viewInsideCell.layer.borderWidth = 1.5
        }
        else {
            cell.viewInsideCell.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            cell.viewInsideCell.layer.borderWidth = 1.5
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}


//MARK:- *****_WEB_API_CALL_******
//mark:-  ****_API: 39
extension liveClassReportVC {
    func API39() {
        
        let Action = "school_live_session_report"
        let StudentType = "2"
        

        var schoolID = UserDefaults.standard.value(forKey: "SCHOOLID")
        var sectionID = UserDefaults.standard.value(forKey: "SECTIONID")
        
        //userId :student_type : boardId: classId :action:Salt:API_key
        
        let checkSumValues =  "\(UserId!):\(StudentType):\(BoardId!):\(ClassId!):\(Action):\(saltMainLMS):\(apikeyMainLMS)"
        
        var uparcaseChecksum = checkSumValues.uppercased()
        
        let myCheckString = MD5(uparcaseChecksum)
        
        let postData = [
            "action": Action,
            "board_id": BoardId,
            "checksum": myCheckString,
            "class_id": ClassId,
            "end_index": 20,
            "school_id":schoolID,
            "section_id": sectionID,
            "start_index": 0,
            "student_type": StudentType,
            "timezone": "Asia/Kolkata",
            "user_id": UserId
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
                            print("THE JSON RESULT",JSON)
                            let Status = JSON["response_code"] as? Int ?? 0
                            print("the status is",Status)
                            let status = JSON["status"] as? Int ?? 0
                            print("the status is ",status)
                            
                            if status == 1 {
                                
                                self.arrSessionList = JSON["session_list"] as? NSArray ?? []
                                
                                self.lblTotalLecture.text = "Total Lectures:\(self.arrSessionList.count)"
                                
                                print("session_list is",self.arrSessionList)
                                
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
