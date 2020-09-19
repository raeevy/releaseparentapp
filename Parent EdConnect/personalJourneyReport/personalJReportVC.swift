//
//  personalJReportVC.swift
//  Parent EdConnect
//
//  Created by Work on 14/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire

class personalJReportVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    var studentId = UserDefaults.standard.value(forKey: "USERID")
    var subjectId = 177
    
    var arrQuickTestDetail = NSArray()
    var arrTestDetail = NSArray()
    
    
    @IBOutlet weak var viewSegment: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewtable: CustomView!
    @IBOutlet weak var btnScience: UIButton!
    @IBOutlet weak var btnMaths: UIButton!
    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var lblMaths: UILabel!
    @IBOutlet weak var lblScience: UILabel!
    @IBOutlet weak var lblEnglish: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "PersonalJRXIB1TVC", bundle: nil), forCellReuseIdentifier: "PersonalJRXIB1TVC")
        self.tableView.rowHeight = UITableView.automaticDimension

//        viewtable.borderColor = #colorLiteral(red: 0.8626691699, green: 0.862793684, blue: 0.8626419902, alpha: 1)
//        viewtable.cornerRadius = 10
//        viewtable.borderWidth = 2
        self.StatusBarSetup()
        
        if BoardId != nil && studentId != nil && ClassId != nil {
            personalizedJourneyReportAPI26()
            PersonalizedJourneySubjectWiseAPI27()
        }
        
//        viewSegment.layer.borderColor = #colorLiteral(red: 0.8626691699, green: 0.862793684, blue: 0.8626419902, alpha: 1)
//        viewSegment.layer.borderWidth = 1.5
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnScience(_ sender: Any) {
        btnScience.setTitleColor(#colorLiteral(red: 0.14805004, green: 0.3711644709, blue: 0.764950335, alpha: 1), for: .normal)
        lblScience.backgroundColor = #colorLiteral(red: 0.9449529648, green: 0.5010166168, blue: 0.2282519341, alpha: 1)
        
        lblMaths.backgroundColor = .clear
        btnMaths.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        
        lblEnglish.backgroundColor = .clear
        btnEnglish.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        tableView.isHidden = false
    }
    
    @IBAction func btnMaths(_ sender: Any) {
        btnMaths.setTitleColor(#colorLiteral(red: 0.14805004, green: 0.3711644709, blue: 0.764950335, alpha: 1), for: .normal)
        lblMaths.backgroundColor = #colorLiteral(red: 0.9449529648, green: 0.5010166168, blue: 0.2282519341, alpha: 1)
        
        lblEnglish.backgroundColor = .clear
        btnEnglish.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        
        lblScience.backgroundColor = .clear
        btnScience.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        tableView.isHidden = true
        alert(message: "No Data Found")
    }
    
    
    @IBAction func btnEnglish(_ sender: Any) {
        btnEnglish.setTitleColor(#colorLiteral(red: 0.14805004, green: 0.3711644709, blue: 0.764950335, alpha: 1), for: .normal)
        lblEnglish.backgroundColor = #colorLiteral(red: 0.9449529648, green: 0.5010166168, blue: 0.2282519341, alpha: 1)
        
        lblScience.backgroundColor = .clear
        btnScience.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        
        lblMaths.backgroundColor = .clear
        btnMaths.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        
        tableView.isHidden = true
        alert(message: "No Data Found")
    }
}

//MARK:- *******-tableViewCycle()-********
//MARK:-
extension personalJReportVC {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrQuickTestDetail.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = Bundle.main.loadNibNamed("PersonalJRXIBUpperTable1TVC", owner: self, options: nil)?.first as! PersonalJRXIBUpperTable1TVC
        
        let arrarrTestDetailDict = self.arrQuickTestDetail[section] as? NSDictionary ?? [:]
        headerCell.lblTopicName.text = arrarrTestDetailDict.value(forKey: "chapter_name") as? String ?? ""
        headerCell.layer.backgroundColor = UIColor.clear.cgColor
        headerCell.layer.cornerRadius = 10
        headerCell.layer.borderWidth = 1
        headerCell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
    //let screenSize: CGRect = UIScreen.main.bounds
//        let myView = UIView(frame: CGRect(x: 0, y: headerCell.width , width: headerCell.frame.width - 10, height: 30))
//        myView.layer.backgroundColor = UIColor.red.cgColor
//        
//    self.view.addSubview(myView)

        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell:PersonalJRXIB1TVC = tableView.dequeueReusableCell(withIdentifier: "PersonalJRXIB1TVC") as? PersonalJRXIB1TVC else { return UITableViewCell() }
      //  cell.viewContenst.shadow(UIView: cell.viewContenst)
        cell.arrTestDetail = self.arrTestDetail
        
     //   For Custom TV Heights.
        cell.customHeightsTV.constant = cell.xibTableView.contentSize.height
        let arrCount:Int = self.arrTestDetail.count ?? 1
        print("arrCount is :-", arrCount)
        cell.customHeightsTV.constant = CGFloat(50 * arrCount)
        cell.parentVC = self
        
//        //For bottom border to tv_title;
//         let frame =  cell.xibTableView.frame
//          let bottomLayer = CALayer()
//         bottomLayer.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
//         bottomLayer.backgroundColor = UIColor.black.cgColor
//         cell.xibTableView.layer.addSublayer(bottomLayer)
//
//        //borderColor,borderWidth, cornerRadius
//        cell.backgroundColor = UIColor.lightGray
//        cell.layer.borderColor = UIColor.red.cgColor
//        cell.layer.borderWidth = 1
//        cell.layer.cornerRadius = 8
//        cell.clipsToBounds = true
        
        
        cell.xibTableView.reloadData()
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let dict = arrTestDetail[indexPath.row] as? NSDictionary ?? [:]
//        let score = dict.value(forKey: "score") as? String ?? ""
//        let userLevel = dict.value(forKey: "user_level") as? String ?? ""
//        let userMessage = dict.value(forKey: "user_message") as? String ?? ""
//        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
//        let VC = storyBoard.instantiateViewController(withIdentifier: "evaluatedWorksheetVC") as! evaluatedWorksheetVC
//        VC.score = score
//        //VC.userLevel = userLevel
//        VC.UserMessage = userMessage
//        self.navigationController?.pushViewController(VC, animated: true)
//        
//    }
}


//mark:-*************_Personalized_Journey_Subject_List_API_26_*******
//mark:- API_26
extension personalJReportVC {
    func  personalizedJourneyReportAPI26() {
        var Salt = saltMain
        var apiKey = apikeyMain
        var isNewApp = 1
        var reportType = "get_personalized_journey_report"
        //   CheckSum Sequence:
        //   boardId : classId : isNew App : studentId : report_type : “” : apiKey : salt
        var checkSumValues =  "\(BoardId!):\(ClassId!):\(isNewApp):\(studentId!):\(reportType):\(""):\(apikeyMain):\(saltMain)"
        
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
            AF.request("\(baseUrl)v1.1/subjectwiseprogressreportindo?board_id=\(BoardId!)&class_id=\(ClassId!)&is_new_app=\(isNewApp)&user_id=\(studentId!)&report_type=\(reportType)&subject_id=&apikey=\(apikeyMain)&checksum=\(myCheckString!)", method: .get, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            
                            self.hideActivityIndicator()
                            print("THE JSON RESULT",JSON)
                            
                            let message = JSON["message"] as? String ?? ""
                            print("the message is",message)
                            
                            if message == "success" {                                      self.hideActivityIndicator()
                                
                                let subjectWisePerformance = JSON["subject_wise_performance"] as? NSArray ?? []
                                let subjectWiseQuickTest = JSON["subject_wise_quick_test"] as? NSArray
                                    ?? []
                                print("subjectWisePerformance",subjectWisePerformance)
                                print("subjectWiseQuickTest",subjectWiseQuickTest)
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

//MARK:- ******_Personalized_Journey_subject_wise_data_API_27___****
//MARK:- API_27
extension personalJReportVC {
    func PersonalizedJourneySubjectWiseAPI27() {
        var Salt = saltMain
        var apiKey = apikeyMain
        var isNewApp = 1
        var reportType = "get_concepts_report"
        
        //CheckSum Sequence:
        //boardId : classId : isNew App : studentId : report_type : subject_id : apiKey : salt
        // 27
        
        
        var checkSumValues =  "\(BoardId!):\(ClassId!):\(isNewApp):\(studentId!):\(reportType):\(subjectId):\(apiKey):\(Salt)"
        
        let myCheckString = MD5(checkSumValues)
        print("the chceksum String", checkSumValues)
        print("converted chceksum value ", myCheckString!)
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            
            AF.request("http://developer.extramarks.com/api/v1.1/subjectwiseprogressreportindo?board_id=180&class_id=36&is_new_app=1&user_id=67567001&report_type=get_concepts_report&subject_id=177&apikey=0DEAD50C6BBA59FF22D33C994&checksum=49208d7c2cfcdd7e39f1aa20e24a0527", method: .get, encoding: JSONEncoding.default, headers: headers)
            
          //  AF.request("\(baseUrl)v1.1/subjectwiseprogressreportindo?board_id=\(BoardId!)&class_id=\(ClassId!)&is_new_app=\(isNewApp)&user_id=\(studentId!)&report_type=\(reportType)&subject_id=\(subjectId)&apikey=\(apikeyMain)&checksum=\(myCheckString!)", method: .get, encoding: JSONEncoding.default, headers: headers)
                
                
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            
                            self.hideActivityIndicator()
                            print("THE JSON2 RESULT",JSON)
                            
                            let message = JSON["message"] as? String ?? ""
                            print("the message is",message)
                            
                            if message == "success" {                       self.hideActivityIndicator()
                                
                                self.arrQuickTestDetail = JSON["quick_test_detail"] as? NSArray ?? []
                                
                                let TestDetail = self.arrQuickTestDetail.value(forKey: "test_detail") as? NSArray ?? []
                                
                                if TestDetail.count != 0 {
                                    self.arrTestDetail = TestDetail.object(at: 0) as? NSArray ?? []
                                }
                                
                                print("arrTestDetail count is",self.arrTestDetail.count)
                                print("arrTestDetail is",self.arrTestDetail)
                                print("quickTestDetail is",self.arrQuickTestDetail)
                                
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
