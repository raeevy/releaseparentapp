//
//  answerKeyGtsVC.swift
//  Parent EdConnect
//
//  Created by Work on 11/08/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire

//API:41  worksheet > subject > attempted > analyse click
//API:43  homework >  subject > attempted > analyse click
//API:45  weekly test > subject > attempted > analyse > test_wise_analysis > answer_key clcik
//API:16 comming from MCQ screen

class answerKeyGtsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate {
    
    var quesStatus:Int?
    var screenCheck:Int?
    var weeklytestId:String?
    var arrRight = NSMutableArray()
    var arrWrong = NSMutableArray()
    var arrSkipped = NSMutableArray()
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    
    @IBOutlet weak var dataTable: UITableView!
    @IBOutlet weak var viewCorrrect: UIView!
    @IBOutlet weak var btnCorrect: UIButton!
    @IBOutlet weak var viewWrong: UIView!
    @IBOutlet weak var btnWrong: UIButton!
    @IBOutlet weak var viewSkipped: UIView!
    @IBOutlet weak var btnSkipped: UIButton!
    @IBOutlet weak var viewSegment: UIView!
    @IBOutlet weak var lblCorrect: UILabel!
    @IBOutlet weak var lblWrong: UILabel!
    @IBOutlet weak var lblSkipped: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if screenCheck == 1 {
            API43()
        }
        else if screenCheck == 2 {
            API45()
        }
        else if screenCheck == 3 {
            API41()
        } else if screenCheck == 4 {
            API16()
        }
                
    }
    override func viewWillAppear(_ animated: Bool) {
        loadUI()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCorrect(_ sender: Any) {
        quesStatus = 0
        dataTable.reloadData()
        btnCorrect.setTitleColor(#colorLiteral(red: 0.3882645965, green: 0.8571659923, blue: 0.620681107, alpha: 1), for: .normal)
        viewCorrrect.backgroundColor = #colorLiteral(red: 0.3882645965, green: 0.8571659923, blue: 0.620681107, alpha: 1)
        btnWrong.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        viewWrong.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnSkipped.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        viewSkipped.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        if arrRight.count == 0 {
            alert(message: "no data found")
        }
    }
    
    @IBAction func btnWrong(_ sender: Any) {
        quesStatus = 1
        dataTable.reloadData()
        btnCorrect.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        viewCorrrect.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnWrong.setTitleColor(#colorLiteral(red: 0.9292399287, green: 0.2608605325, blue: 0.3604906797, alpha: 1), for: .normal)
        viewWrong.backgroundColor = #colorLiteral(red: 0.9146355987, green: 0.2572265267, blue: 0.3555603027, alpha: 1)
        btnSkipped.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        viewSkipped.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        if arrWrong.count == 0 {
            alert(message: "no data found")
        }
    }
    
    
    @IBAction func btnSkipped(_ sender: Any) {
        quesStatus = 2
        dataTable.reloadData()
        btnCorrect.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        viewCorrrect.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnWrong.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        viewWrong.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnSkipped.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        viewSkipped.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        if arrSkipped.count == 0 {
            alert(message: "no data found")
        }
    }
    
}


//Mark:- *********_TableView_Cycle_***********
//Mark:-
extension answerKeyGtsVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if quesStatus == 0 {
            return arrRight.count
        } else if quesStatus == 1 {
            return arrWrong.count
            
        } else  {
            return arrSkipped.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerKeyGTSTVCELL") as! answerKeyGTSTVCELL
        cell.viewInsideCell.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        cell.viewInsideCell.cornerRadius = 10
        cell.viewInsideCell.borderWidth = 2
        if quesStatus == 0 {
            
            let dict = arrRight[indexPath.row] as? NSDictionary ?? [:]
  
            let quesNum = dict.value(forKey: "question_number") as? String ?? ""
            cell.lblQuesNumber.text = "Question \(quesNum)"
            
            
            let question = dict.value(forKey: "question") as? String ?? ""
            let htmlString = dict.value(forKey: "explanatation") as? String ?? ""


            if screenCheck == 1{
                cell.lblExpalnation.isHidden = false
                cell.webView.isHidden = true
                cell.lblQuestion.text = question
                cell.lblExpalnation.text = htmlString
                
            }
            else {
                cell.lblExpalnation.isHidden = true
                cell.webView.isHidden = false
                cell.lblQuestion.attributedText = question.htmlAttributedString()
                cell.webView.loadHTMLString(htmlString, baseURL: nil)
            }
            
            cell.btnAnsStatus.setImage(UIImage(named: "rightTick"), for: .normal)
            cell.lblRightAns.text = "-"
            cell.lblWrongAns.text = "-"
        }
        else if quesStatus == 1 {
            let dict = arrWrong[indexPath.row] as? NSDictionary ?? [:]
            
            let quesNum = dict.value(forKey: "question_number") as? String ?? ""
            cell.lblQuesNumber.text = "Question \(quesNum)"
            
            let question = dict.value(forKey: "question") as? String ?? ""
            let htmlString = dict.value(forKey: "explanatation") as? String ?? ""
            
            if screenCheck == 1{
                cell.lblExpalnation.isHidden = false
                cell.webView.isHidden = true
                cell.lblQuestion.text = question
                cell.lblExpalnation.text = htmlString
            }
            else {
                cell.lblExpalnation.isHidden = true
                cell.webView.isHidden = false
                cell.lblQuestion.attributedText = question.htmlAttributedString()
                cell.webView.loadHTMLString(htmlString, baseURL: nil)
            }
            
            cell.btnAnsStatus.setImage(UIImage(named: "wrongTick"), for: .normal)
            cell.lblRightAns.text = "-"
            cell.lblWrongAns.text = "-"
        }
        else if quesStatus == 2 {
            let dict = arrSkipped[indexPath.row] as? NSDictionary ?? [:]
            
            let quesNum = dict.value(forKey: "question_number") as? String ?? ""
            cell.lblQuesNumber.text = "Question \(quesNum)"
            
            let question = dict.value(forKey: "question") as? String ?? ""
            let htmlString = dict.value(forKey: "explanatation") as? String ?? ""
            
            if screenCheck == 1{
                cell.lblExpalnation.isHidden = false
                cell.webView.isHidden = true
                cell.lblQuestion.text = question
                cell.lblExpalnation.text = htmlString
            }  else if screenCheck == 2 {
                cell.lblExpalnation.isHidden = true
                cell.webView.isHidden = false
                cell.lblQuestion.attributedText = question.htmlAttributedString()
                cell.webView.loadHTMLString(htmlString, baseURL: nil)
            }
                
            else {
                cell.lblExpalnation.isHidden = true
                cell.webView.isHidden = false
                cell.lblQuestion.attributedText = question.htmlAttributedString()
                cell.webView.loadHTMLString(htmlString, baseURL: nil)
            }
            
            cell.btnAnsStatus.setImage(UIImage(named: "skippedTick"), for: .normal)
            cell.lblRightAns.text = "-"
            cell.lblWrongAns.text = "-"
        }
        
        return cell
    }
    //MARK:- ******_heightForRow_table_view*****
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 380
    }
    //MARK:- ******_didSelectRowAt_table_view*****
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


//weekely > sub > attempted > test_wise_analysis > answerkey
//MARK:- *****_WEB_API_CALL_******
//mark:-  ****_API:41
extension answerKeyGtsVC {
    func API41() {
                
        var Action = "question_wise_analysis"
        var paperType = "10"
        var studentType = "2"
        
        self.quesStatus = 0
       // testIds:userId :student_type :action:paperType :Salt:API_key

        let checkSumValues =  "\(weeklytestId!):\(UserId!):\(studentType):\(Action):\(paperType):\(saltMainLMS):\(apikeyMainLMS)"
        var uparcaseChecksum = checkSumValues.uppercased()
        let myCheckString = MD5(uparcaseChecksum)
            
        let postData = [
            "weeklytest_Id":weeklytestId,
            "user_id": UserId,
            "student_type": "2",
            "action": Action,
            "paper_type": "10",
            "checksum":myCheckString
            ] as [String : Any]
        
       
        
        print("the chceksum String41", checkSumValues)
        print("converted chceksum MD5 value 4 ", myCheckString!)
        print("postData is 41",postData)
        
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
                            
                            let arrQuesWiseDetail = JSON["question_wise_detail"] as? NSArray ?? []
                            print("arrQuesWiseDetail is",arrQuesWiseDetail)
                            
                          
                            if arrQuesWiseDetail != nil || arrQuesWiseDetail.count != 0 {
                                
                                for (index, element) in arrQuesWiseDetail.enumerated() {
                                    
                                    let dataDict = arrQuesWiseDetail.object(at: index) as? NSDictionary ?? [:]
                                    
                                    let dicOptiondata = dataDict.value(forKey: "optiondata") as? NSDictionary ?? [:]
                                    
                                    print("dicOptiondata is",dicOptiondata)
                                    
                                    let status = dataDict.value(forKey: "question_status") as? String ?? ""
                                    
                                    print("the status is",status)
                                    
                                    if status == "right" {
                                        self.arrRight.add(element)
                                    }
                                    else if status == "wrong" {
                                        self.arrWrong.add(element)
                                    }
                                }
                                
                            }
                            
                            if self.arrRight.count == 0 {
                                self.alert(message: "no data found")
                            }
                            self.lblCorrect.text = "\(self.arrRight.count)"
                            self.lblWrong.text = "\(self.arrWrong.count)"
                            self.lblSkipped.text = "\(self.arrSkipped.count)"
                            
                            print("arrRight  count in api ",self.arrRight.count)
                            print("arrWrong is",self.arrWrong)
                                                        print("Right.count",self.arrRight.count)
                            print("Wrong.count",self.arrWrong.count)
                            print("Skipped.count",self.arrSkipped.count)
                            
                            self.dataTable.reloadData()
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

extension answerKeyGtsVC {
    func loadUI() {
        viewSegment.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        viewSegment.layer.borderWidth = 1.5
        viewSkipped.layer.cornerRadius = viewSkipped.frame.size.width / 2
        viewSkipped.clipsToBounds = true
        viewCorrrect.layer.cornerRadius = viewCorrrect.frame.size.width / 2
        viewCorrrect.clipsToBounds = true
        viewWrong.layer.cornerRadius = viewWrong.frame.size.width / 2
        viewWrong.clipsToBounds = true
    }
}


//worksheet > sub > attempted > analyse
extension answerKeyGtsVC {
    
    func API43() {
        
        
        var Action = "question_wise_analysis"
        var paperType = "10"
        var studentType = "2"
        
        //testIds:userId :student_type :action:paperType :Salt:API_key

        let checkSumValues =  "\(weeklytestId!):\(UserId!):\(studentType):\(Action):\(paperType):\(saltMainLMS):\(apikeyMainLMS)"
        var uparcaseChecksum = checkSumValues.uppercased()
        let myCheckString = MD5(uparcaseChecksum)
        
        
        self.quesStatus = 0
        let postData = [
            "weeklytest_Id":weeklytestId,
            "user_id": UserId,
            "student_type": "2",
            "action": Action,
            "paper_type": "10",
            "checksum": myCheckString
            ] as [String : Any]
        
        print("the chceksum String 43", checkSumValues)
        print("converted chceksum MD5 value 43", myCheckString!)
        print("postData is 43",postData)
        
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
                            
                            let arrQuesWiseDetail = JSON["question_wise_detail"] as? NSArray ?? []
                            print("arrQuesWiseDetail is",arrQuesWiseDetail)
                            
                            if arrQuesWiseDetail != nil || arrQuesWiseDetail.count != 0 {
                                
                                
                                for (index, element) in arrQuesWiseDetail.enumerated() {
                                    
                                    let dataDict = arrQuesWiseDetail.object(at: index) as? NSDictionary ?? [:]
                                    
                                    let dicOptiondata = dataDict.value(forKey: "optiondata") as? NSDictionary ?? [:]
                                    
                                    print("dicOptiondata is",dicOptiondata)
                                    
                                    let status = dataDict.value(forKey: "question_status") as? String ?? ""
                                    
                                    print("the status is",status)
                                    
                                    if status == "right" {
                                        self.arrRight.add(element)
                                    }
                                    else if status == "wrong" {
                                        self.arrWrong.add(element)
                                    }
                                }
                                
                            }
                            
                            
                            if self.arrRight.count == 0 {
                                self.alert(message: "no data found")
                            }
                            self.lblCorrect.text = "\(self.arrRight.count)"
                            self.lblWrong.text = "\(self.arrWrong.count)"
                            self.lblSkipped.text = "\(self.arrSkipped.count)"
                            
                            print("arrRight  count in api ",self.arrRight.count)
                            print("arrWrong is",self.arrWrong)
                            
                            
                            print("Right.count",self.arrRight.count)
                            print("Wrong.count",self.arrWrong.count)
                            print("Skipped.count",self.arrSkipped.count)
                            
                            self.dataTable.reloadData()
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

//homework > sub > attempted > analyse
extension answerKeyGtsVC {
    
    func API45() {
        self.quesStatus = 0
        
        var Action = "question_wise_analysis"
        var paperType = "10"
        var studentType = "2"
        
      //  testIds:userId :student_type :action:paperType :Salt:API_key
        
        let checkSumValues =  "\(weeklytestId!):\(UserId!):\(studentType):\(Action):\(paperType):\(saltMainLMS):\(apikeyMainLMS)"
        var uparcaseChecksum = checkSumValues.uppercased()
        let myCheckString = MD5(uparcaseChecksum)
        
        
        let postData = [
            "weeklytest_Id":weeklytestId,
            "user_id": UserId,
            "student_type": "2",
            "action": Action,
            "paper_type": "10",
            "checksum": myCheckString
            ] as [String : Any]
                
        print("the chceksum String 45", checkSumValues)
        print("converted chceksum MD5 value 45", myCheckString!)
        print("postData is 45",postData)
        
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
                            
                            let arrQuesWiseDetail = JSON["question_wise_detail"] as? NSArray ?? []
                            print("arrQuesWiseDetail is",arrQuesWiseDetail)
                            
                            if arrQuesWiseDetail != nil || arrQuesWiseDetail.count != 0 {
                                
                                
                                for (index, element) in arrQuesWiseDetail.enumerated() {
                                    
                                    let dataDict = arrQuesWiseDetail.object(at: index) as? NSDictionary ?? [:]
                                    
                                    let dicOptiondata = dataDict.value(forKey: "optiondata") as? NSDictionary ?? [:]
                                    
                                    print("dicOptiondata is",dicOptiondata)
                                    
                                    let status = dataDict.value(forKey: "question_status") as? String ?? ""
                                    
                                    print("the status is",status)
                                    
                                    if status == "right" {
                                        self.arrRight.add(element)
                                    }
                                    else if status == "wrong" {
                                        self.arrWrong.add(element)
                                    }
                                }
                                
                            }
                            
                            
                            if self.arrRight.count == 0 {
                                self.alert(message: "no data found")
                            }
                            self.lblCorrect.text = "\(self.arrRight.count)"
                            self.lblWrong.text = "\(self.arrWrong.count)"
                            self.lblSkipped.text = "\(self.arrSkipped.count)"
                            
                            print("arrRight  count in api ",self.arrRight.count)
                            print("arrWrong is",self.arrWrong)
                            
                            
                            print("Right.count",self.arrRight.count)
                            print("Wrong.count",self.arrWrong.count)
                            print("Skipped.count",self.arrSkipped.count)
                            
                            self.dataTable.reloadData()
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


//MARK:- *********_API_NO:16_*******
//MARK:-comming form MCQ Level screen

extension answerKeyGtsVC {
    
    func API16() {
        self.quesStatus = 0
        
        var Action = "question_wise_analysis"
        var paperType = "10"
        var studentType = "2"
        
      // test_id : user_id  :  studnet_type  : action   : paper_type : SALT   : API KEY

        
        let checkSumValues =  "\(weeklytestId!):\(UserId!):\(studentType):\(Action):\(paperType):\(saltMainLMS):\(apikeyMainLMS)"
        var uparcaseChecksum = checkSumValues.uppercased()
        let myCheckString = MD5(uparcaseChecksum)
        
        
        let postData = [
           "weeklytest_Id":"4040",
            "user_id":UserId,
            "student_type":studentType,
            "action":Action,
            "paper_type":paperType,
            "checksum":myCheckString
            ] as [String : Any]
                
        print("the chceksum String 45", checkSumValues)
        print("converted chceksum MD5 value 45", myCheckString!)
        print("postData is 45",postData)
        
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
                            
                            let arrQuesWiseDetail = JSON["question_wise_detail"] as? NSArray ?? []
                            print("arrQuesWiseDetail is",arrQuesWiseDetail)
                            
                            if arrQuesWiseDetail != nil || arrQuesWiseDetail.count != 0 {
                                
                                
                                for (index, element) in arrQuesWiseDetail.enumerated() {
                                    
                                    let dataDict = arrQuesWiseDetail.object(at: index) as? NSDictionary ?? [:]
                                    
                                    let dicOptiondata = dataDict.value(forKey: "optiondata") as? NSDictionary ?? [:]
                                    
                                    print("dicOptiondata is",dicOptiondata)
                                    
                                    let status = dataDict.value(forKey: "question_status") as? String ?? ""
                                    
                                    print("the status is",status)
                                    
                                    if status == "right" {
                                        self.arrRight.add(element)
                                    }
                                    else if status == "wrong" {
                                        self.arrWrong.add(element)
                                    }
                                }
                            }
                            
                            
                            if self.arrRight.count == 0 {
                                self.alert(message: "no data found")
                            }
                            self.lblCorrect.text = "\(self.arrRight.count)"
                            self.lblWrong.text = "\(self.arrWrong.count)"
                            self.lblSkipped.text = "\(self.arrSkipped.count)"
                            
                            print("arrRight  count in api ",self.arrRight.count)
                            print("arrWrong is",self.arrWrong)
                            print("Right.count",self.arrRight.count)
                            print("Wrong.count",self.arrWrong.count)
                            print("Skipped.count",self.arrSkipped.count)
                            
                            self.dataTable.reloadData()
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
