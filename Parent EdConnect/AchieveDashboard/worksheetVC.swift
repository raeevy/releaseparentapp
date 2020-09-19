//
//  worksheetVC.swift
//  Parent EdConnect
//
//  Created by Work on 08/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire

class worksheetVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    var name = UserDefaults.standard.value(forKey: "NAME")
    var email = UserDefaults.standard.value(forKey: "EMAIL")
    var studentId = UserDefaults.standard.value(forKey: "CHILDID")
    var Class = UserDefaults.standard.value(forKey: "CLASS")

    var assignmentType:String?
    var arrSubjectId = NSMutableArray()
    var arrTable = NSArray()
    var arrScience = NSArray()
    var arrMaths = NSArray()
    var arrEnglish = NSArray()
    
    
    var segValue:Int?
    
    
    @IBOutlet weak var viewGraphLoader: CircularArc!
    @IBOutlet weak var lblScreenName: UILabel!
    @IBOutlet weak var viewOverAllWorksheet: CustomView!
    @IBOutlet weak var viewForTableShadow: CustomView!
    @IBOutlet weak var lblAttemptedWorksheet: UILabel!
    @IBOutlet weak var lblOverAllPorogress: UILabel!
    @IBOutlet weak var lblAssignedWorksheet: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSegment: UIView!
    @IBOutlet weak var lblMaths: UILabel!
    @IBOutlet weak var lblScience: UILabel!
    @IBOutlet weak var lblEnglish: UILabel!
    @IBOutlet weak var btnScience: UIButton!
    @IBOutlet weak var btnMaths: UIButton!
    @IBOutlet weak var btnEnglish: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.StatusBarSetup()
        viewSegment.shadow(UIView: viewSegment)
        
        viewOverAllWorksheet.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        viewOverAllWorksheet.cornerRadius = 10
        viewOverAllWorksheet.borderWidth = 2
        
        viewForTableShadow.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        viewForTableShadow.cornerRadius = 10
        viewForTableShadow.borderWidth = 2
        
        if UserId != nil && ClassId != nil && BoardId != nil {
                   worksheetApi()
               }
               else {
                   alert(message: "something went wrong")
               }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        segValue = 0
        
        if assignmentType == "17" {
            lblScreenName.text = "Worksheet"
        }
        else if assignmentType == "18" {
            lblScreenName.text = "Homework"
        }
//        BoardClassListApi()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
                return .lightContent
          }
    

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnScience(_ sender: Any) {
        segValue = 0
        worksheetApi()
        btnScience.setTitleColor(#colorLiteral(red: 0.14805004, green: 0.3711644709, blue: 0.764950335, alpha: 1), for: .normal)
        lblScience.backgroundColor = #colorLiteral(red: 0.9449529648, green: 0.5010166168, blue: 0.2282519341, alpha: 1)
        
        lblMaths.backgroundColor = .clear
        lblEnglish.backgroundColor = .clear
        
        btnEnglish.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        btnMaths.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
    }
    
    @IBAction func btnMaths(_ sender: Any) {
        segValue = 1
        worksheetApi()
        btnMaths.setTitleColor(#colorLiteral(red: 0.14805004, green: 0.3711644709, blue: 0.764950335, alpha: 1), for: .normal)
        lblMaths.backgroundColor = #colorLiteral(red: 0.9449529648, green: 0.5010166168, blue: 0.2282519341, alpha: 1)
     
        lblScience.backgroundColor = .clear
        lblEnglish.backgroundColor = .clear
        
        btnEnglish.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        btnScience.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
    }
    
    @IBAction func btnEnglish(_ sender: Any) {
        
        segValue = 2
        worksheetApi()
        btnEnglish.setTitleColor(#colorLiteral(red: 0.14805004, green: 0.3711644709, blue: 0.764950335, alpha: 1), for: .normal)
        lblEnglish.backgroundColor = #colorLiteral(red: 0.9449529648, green: 0.5010166168, blue: 0.2282519341, alpha: 1)
        
        lblMaths.backgroundColor = .clear
        lblScience.backgroundColor = .clear
        
        btnMaths.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        btnScience.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
    }
    

}

//MARK:- API NO 19
//
extension worksheetVC {
    
    func worksheetApi() {
        var action = "get_assignment_repor"
        var studentType = "2"
        var apiKey = apikeyMain
        var salt = saltMain

        if assignmentType == "17" {
            lblScreenName.text = "Worksheet"
        }
        else if assignmentType == "18" {
            lblScreenName.text = "Homework"
        }
     
        var checkSum =  "\(UserId!):\("2"):\(BoardId!):\(36):\(action):\("17"):\(salt):\(apiKey)"
        
        var uparcaseChecksum = checkSum.uppercased()
        let myChecksum = MD5(uparcaseChecksum)
    
        let postData = [
            "action":"get_assignment_report",
            "assignment_type":"17",
            "board_id":"180",
            "checksum":"6d3c106f696071b26ef776873c4d9718",
            "class_id":"36",
            "language_code":"01",
            "student_id":"67567001",
            "student_type":"2",
            "user_subject_list":"177,176,171,182,557202,206,203,310768,214"
            ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        
        print("the chceksum String", checkSum)
        print("uparcaseChecksum is",uparcaseChecksum)
        print("converted chceksum MD5 value ", myChecksum!)
        print("postData is",postData)
        
        if Reachability.isConnectedToNetwork() {
           showActivityIndicator()
            AF.request("\(baseUrl)school_lms/public/api/v1.0/weeklyv2", method: .post, parameters: postData, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                            print("THE JSON RESULT",JSON)
                           let arrayReport = JSON["reports"] as? NSArray ?? []
                            print("arrayReport is",arrayReport)
                            
                            if arrayReport.count != 0 {
                                
                                var arrayEnglish = arrayReport.object(at: 2) as? NSDictionary ?? [:]
                                var arrayScience = arrayReport.object(at: 5) as? NSDictionary ?? [:]
                                var arrayMaths = arrayReport.object(at: 6) as? NSDictionary ?? [:]
                                
                                self.arrScience = arrayScience.object(forKey: "subject_wise_analysis") as? NSArray ?? []
                                self.arrTable = arrayScience.object(forKey: "subject_wise_analysis") as? NSArray ?? []
                                self.arrMaths = arrayMaths.object(forKey: "subject_wise_analysis") as? NSArray ?? []
                                self.arrEnglish = arrayEnglish.object(forKey: "subject_wise_analysis") as? NSArray ?? []
                                print("self.arrMaths",self.arrMaths)
                                if self.segValue == 0 {
                                    let assignedWorksheets = arrayScience.object(forKey: "total_worksheets") as? String ?? ""
                                    let attemptedWorksheets = arrayScience.object(forKey: "attempted_worksheets") as? String ?? ""
                                    let overallProgress = arrayScience.object(forKey: "overall_progress") as? String ?? ""
                                    
                                    self.lblOverAllPorogress.text = overallProgress
                                    
                                    let int1 = Int(assignedWorksheets)
                                    let int2 = Int(attemptedWorksheets)
                                    
                                    self.lblAssignedWorksheet.text = "\(assignedWorksheets) Assigned Worksheet"
                                    self.lblAttemptedWorksheet.text = "\(attemptedWorksheets) Attempted Worksheet"
                                    
                                    var arcArray: [Arc] = [Arc]()
                                    arcArray.append(Arc(c: #colorLiteral(red: 0.9523274302, green: 0.5835757852, blue: 0.2794597745, alpha: 1), v: Double(int1!)))
                                    arcArray.append(Arc(c: #colorLiteral(red: 0, green: 0.1934992969, blue: 0.7240211964, alpha: 1), v: Double(int2!)))
                                    self.viewGraphLoader.Start(array: arcArray, lWidth: 8.0)
                                    
                                    //  self.arrScience = self.arrTable
                                    //print("arrTable for science",self.arrTable)
                                    self.tableView.reloadData()
                                }
                                else if self.segValue == 1 {
                                    let assignedWorksheets = arrayMaths.object(forKey: "total_worksheets") as? String ?? ""
                                    let attemptedWorksheets = arrayMaths.object(forKey: "attempted_worksheets") as? String ?? ""
                                    let overallProgress = arrayMaths.object(forKey: "overall_progress") as? String ?? ""
                                    
                                    self.lblOverAllPorogress.text = overallProgress
                                    
                                    let int1 = Int(assignedWorksheets)
                                    let int2 = Int(attemptedWorksheets)
                                    
                                    self.lblAssignedWorksheet.text = "\(assignedWorksheets) Assigned Worksheet"
                                    self.lblAttemptedWorksheet.text = "\(attemptedWorksheets) Attempted Worksheet"
                                    
                                    var arcArray: [Arc] = [Arc]()
                                    arcArray.append(Arc(c: #colorLiteral(red: 0.9523274302, green: 0.5835757852, blue: 0.2794597745, alpha: 1), v: Double(int1!)))
                                    arcArray.append(Arc(c: #colorLiteral(red: 0, green: 0.1934992969, blue: 0.7240211964, alpha: 1), v: Double(int2!)))
                                    self.viewGraphLoader.Start(array: arcArray, lWidth: 8.0)
                                    
                                    //                                self.arrMaths = self.arrTable
                                    self.tableView.reloadData()
                                }
                                else if self.segValue == 2 {
                                    
                                    let assignedWorksheets = arrayEnglish.object(forKey: "total_worksheets") as? String ?? ""
                                    let attemptedWorksheets = arrayEnglish.object(forKey: "attempted_worksheets") as? String ?? ""
                                    let overallProgress = arrayEnglish.object(forKey: "overall_progress") as? String ?? ""
                                    
                                    self.lblOverAllPorogress.text = overallProgress
                                    
                                    let int1 = Int(assignedWorksheets)
                                    let int2 = Int(attemptedWorksheets)
                                    
                                    self.lblAssignedWorksheet.text = "\(assignedWorksheets) Assigned Worksheet"
                                    self.lblAttemptedWorksheet.text = "\(attemptedWorksheets) Attempted Worksheet"
                                    var arcArray: [Arc] = [Arc]()
                                    arcArray.append(Arc(c: #colorLiteral(red: 0.9523274302, green: 0.5835757852, blue: 0.2794597745, alpha: 1), v: Double(int1!)))
                                    arcArray.append(Arc(c: #colorLiteral(red: 0, green: 0.1934992969, blue: 0.7240211964, alpha: 1), v: Double(int2!)))
                                    self.viewGraphLoader.Start(array: arcArray, lWidth: 8.0)
                                    
                                    //                                self.arrEnglish = self.arrTable
                                    
                                    self.tableView.reloadData()
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




//MARK:- *******-tableViewCycle()-********
//MARK:-
extension worksheetVC {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }
        else {
            
            if segValue == 0 {
                return arrScience.count
            }
            else if segValue == 1{
                return arrMaths.count
                
            }
            else if segValue == 2 {
                return arrEnglish.count
            }
        }
        
        return arrTable.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sheetWorktTVCell") as! sheetWorktTVCell
            return cell
            
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "sheetWorktTVCell2") as! sheetWorktTVCell
            
            if segValue == 0 {
                let dict = self.arrScience[indexPath.row] as? NSDictionary ?? [:]
                
                let assignment_name = dict.value(forKey: "assignment_name") as? String ?? ""
                let assigned_date = dict.value(forKey: "assigned_date") as? String ?? ""
                
                cell.lblWorksheetName.text = "Worksheet: \(assignment_name)"
                cell.lblDate.text = "Assigned Date:\(assigned_date.prefix(10))"
            }
            else if segValue == 1 {
                let dict = self.arrMaths[indexPath.row] as? NSDictionary ?? [:]
                
                let assignment_name = dict.value(forKey: "assignment_name") as? String ?? ""
                let assigned_date = dict.value(forKey: "assigned_date") as? String ?? ""
                
                cell.lblWorksheetName.text = "Worksheet: \(assignment_name)"
                cell.lblDate.text = "Assigned Date:\(assigned_date.prefix(10))"
            }
            else if segValue == 2 {
                let dict = self.arrEnglish[indexPath.row] as? NSDictionary ?? [:]
                let assignment_name = dict.value(forKey: "assignment_name") as? String ?? ""
                let assigned_date = dict.value(forKey: "assigned_date") as? String ?? ""
                
                cell.lblWorksheetName.text = "Worksheet: \(assignment_name)"
                cell.lblDate.text = "Assigned Date:\(assigned_date.prefix(10))"
            }
            cell.btnAnalyse.btnGradientCrop(UIButton: cell.btnAnalyse)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        }
        else {
              let cell = tableView.dequeueReusableCell(withIdentifier: "sheetWorktTVCell2") as! sheetWorktTVCell
            if segValue == 0 {
                let dict = self.arrScience[indexPath.row] as? NSDictionary ?? [:]
                 let assignment_name = dict.value(forKey: "assignment_name") as? String ?? ""
                 let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
                let VC = storyBoard.instantiateViewController(withIdentifier: "subjectWiseAnalysis") as! subjectWiseAnalysis
                VC.subname = assignment_name
                VC.screenReuse = 0
                self.navigationController?.pushViewController(VC, animated: true)
            }
            if segValue == 1 {
                let dict = self.arrMaths[indexPath.row] as? NSDictionary ?? [:]
                 let assignment_name = dict.value(forKey: "assignment_name") as? String ?? ""
                 let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
                let VC = storyBoard.instantiateViewController(withIdentifier: "subjectWiseAnalysis") as! subjectWiseAnalysis
                VC.subname = assignment_name
                VC.screenReuse = 0
                self.navigationController?.pushViewController(VC, animated: true)
            }
            if segValue == 2 {
                let dict = self.arrEnglish[indexPath.row] as? NSDictionary ?? [:]
                let assignment_name = dict.value(forKey: "assignment_name") as? String ?? ""
                 let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
                let VC = storyBoard.instantiateViewController(withIdentifier: "subjectWiseAnalysis") as! subjectWiseAnalysis
                VC.subname = assignment_name
                VC.screenReuse = 0
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 40
        }
        else {
            return 90
        }
    }
}

//
////mark:-*************_API-NO.24_Board_Class_List_Api******
////mark:-
//
//extension worksheetVC {
//        func  BoardClassListApi() {
//
//
//            let checkSumValues =  "\(0):\(ClassId!):\(studentId!):\("class:0:50"):\("mcq"):\(apiKeyj):\(Saltj)"
//
//            let myCheckString = MD5(checkSumValues)
//
//            print("the chceksum String", checkSumValues)
//            print("converted chceksum value ", myCheckString!)
//
//            let headers: HTTPHeaders = [
//                "accept": "application/json",
//                "content-type": "application/json",
//            ]
//           // 180:36:1:67710419
//
//            if Reachability.isConnectedToNetwork() {
//                showActivityIndicator()
//                AF.request("http://developer.extramarks.com/api/v1.1/boardclasslists?all_board_id=0&parent_id=36&user_id=67567001&parent=class&start=0&offset=50&type=mcq&apikey=47C7C9F7711308555B400B9D0&checksum=2a7153f74ad18aff40f9f7baeff24094", method: .get, encoding: JSONEncoding.default, headers: headers)
//
//                    .responseJSON { (response) in
//                        switch response.result {
//                        case .success:
//                            if let JSON = response.value as? [String: Any]  {
//
//                                self.hideActivityIndicator()
//                                print("THE JSON2 RESULT",JSON)
//                                let message = JSON["message"] as? String ?? ""
//                                print("the message is",message)
//
//                                if message == "success" {
//                                    let arrContent = JSON["content"] as? NSArray ?? []
//                                    let arrSubjects = arrContent.value(forKey: "subjects") as? NSArray ?? []
//                                    let arrSubjectElement0 = arrSubjects.object(at: 0) as? NSArray ?? []
//                                    for (index, _) in arrSubjectElement0.enumerated() {
//                                        let dataDict = arrSubjectElement0.object(at: index) as? NSDictionary ?? [:]
//                                        let subjectId = dataDict.value(forKey: "subject_id") as? Int ?? 0
//                                        self.arrSubjectId.add(subjectId)
//                                    }
//                                    print("arrSubjectId is",self.arrSubjectId)
//                                }
//                            }
//                        case .failure(let error):
//                            self.hideActivityIndicator()
//                            print("ERROR", error.localizedDescription)
//                            self.alert(message: error.localizedDescription)
//                    }
//                }
//            }
//            else {
//                self.hideActivityIndicator()
//                alert(message: "No Internet Connection!!")
//        }
//    }
//}
