//
//  learningProgressVC.swift
//  Parent EdConnect
//
//  Created by Work on 07/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire

class learningProgressVC: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var testAdaptive = NSArray()
    var arrMasterOfMaterials = NSArray()
    var arrContentConsumption = NSArray()
    var subjectDetailDict = NSDictionary()
    var statics = NSDictionary()
    var keyFocusArea = NSArray()
    var subNameCov:String?
    var performancePercentagePerformance:Double?
    var subjectId:Int?

    
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSyllabusCov(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func didTapViewTestAttemped(_ sender: UIButton) {
        
        let storyBord = UIStoryboard(name: "Home", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "AttemptedTestsVC") as! AttemptedTestsVC
        VC.subID = self.subjectId
        VC.subNameCov = self.subNameCov
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StatusBarSetup()
        
        if BoardId != nil && ClassId != nil && UserId != nil {
            self.learningPerformanceAPI()
        }
        
        
    }
    ///Mark:-Status Bar Change
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}


//MARK:- *******-tableViewCycle()-********
//MARK:-
extension learningProgressVC {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else if section == 1{
            return 1
        }
        else if section == 2{
            return 1
        }
        else if section == 3{
            return 1
        }
        else if section == 4{
            return 1
        }
        else if section == 5{
            return 1
        }
        else {
            return self.keyFocusArea.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
                       
            let cell = tableView.dequeueReusableCell(withIdentifier: "learnigProgressTVCell") as! learnigProgressTVCell
            cell.viewAccuracy.gradientBlueWithCornerRadius()
            cell.barAccuracy.setProgress(50, animated: false)
//            cell.barAccuracy.transform = cell.barAccuracy.transform.scaledBy(x: 1, y: 2)
            cell.btnViewTestAttempt.btnGradientCrop(UIButton: cell.btnViewTestAttempt)
            cell.viewAvgScore.shadow(UIView: cell.viewAvgScore)
            cell.viewRedC.layer.cornerRadius = 8
            cell.viewSilverC.layer.cornerRadius = 8
            cell.viewGreenCircal.layer.cornerRadius = 8
            
            
            let correctAns = self.subjectDetailDict.value(forKey: "wrong_answer") as? Int ?? 0
            let wrongAns = self.subjectDetailDict.value(forKey: "correct_answer") as? Int ?? 0
            let skipped = self.subjectDetailDict.value(forKey: "missed_answer") as? Int ?? 0
            
            cell.lblWrongAns.text = "\(wrongAns)"
            cell.lblCorrectAnsShow.text = "\(correctAns)"
            cell.lblSkipedAns.text = "\(skipped)"
            
            var arcArray: [Arc] = [Arc]()
            arcArray.removeAll()
            arcArray.append(Arc(c: #colorLiteral(red: 0.4033602476, green: 0.8931822777, blue: 0.6872150898, alpha: 1), v: Double(correctAns) ))
            arcArray.append(Arc(c: #colorLiteral(red: 0.9218646884, green: 0.4113363922, blue: 0.4478791952, alpha: 1), v: Double(wrongAns)))
            arcArray.append(Arc(c: #colorLiteral(red: 0.5921034217, green: 0.5921911597, blue: 0.592084229, alpha: 1), v: Double(skipped)))
            print("after ararray",arcArray)
            cell.viewLoderTop.Start(array: arcArray, lWidth: 8.0)
            
//            let avrValue = self.subjectDetailDict.value(forKey: "average_score") as? Double ?? 0.0
            let avrValueInt = Int(self.performancePercentagePerformance ?? 0.0)
            
            cell.lblShowScoreOnTop.text = "\(avrValueInt)"
            
            
            cell.lblSubName.text = self.subNameCov
                //self.subjectDetailDict.value(forKey: "subject_name") as? String ?? ""
            cell.lblShowNoOfTakenTast.text = "\(self.subjectDetailDict.value(forKey: "number_of_test_taken") as? String ?? "")"
            
            
            let scorePercantage = self.performancePercentagePerformance ?? 0.0
                //self.subjectDetailDict.value(forKey: "accuracy") as? Double ?? 0.0
            let max = 100.0
            let progressValue =  scorePercantage / 100.0
            cell.barAccuracy.setProgress(Float(progressValue), animated: false)
            
//            let valueD = self.subjectDetailDict.value(forKey: "accuracy") as? Double ?? 0.0
            let valueInt = Int(self.performancePercentagePerformance ?? 0.0)
            cell.lblShowAccurencyValue.text = "\(valueInt)%"
            
            
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "learnigProgressTVCell2") as! learnigProgressTVCell
            
            return cell
        }
            
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "learnigProgressTVCell3") as! learnigProgressTVCell
            cell.viewloadCorrectRespTime.Start(value: 50, color: UIColor.orange)
            cell.viewloadavrTestDuration.Start(value: 30, color: UIColor.orange)
            cell.viewStatictics.gradientBlueWithCornerRadius()
            
            
            let totalTime = self.statics.value(forKey: "total_time") as? Double ?? 0.0
            
            let totalAccuracy = self.statics.value(forKey: "average_test_duration") as? Double ?? 0.0
            let conceptAccuracy = self.statics.value(forKey: "quick_answer") as? Double ?? 0.0
            
            cell.lblTotalTimeShow.text = "\(totalTime) Hours"
            cell.lblAvrageTimeShow.text = "\(totalAccuracy)question/ min "
            cell.lblAvrageTimeShow.text = "\(conceptAccuracy) minutes/ test"
            
            let dobTotalAccuracy = Double(totalAccuracy)
            let dobConceptAccuracy = Double(conceptAccuracy)
            
            cell.viewloadCorrectRespTime.Start(value: dobTotalAccuracy ?? 0.0, color: orangeColor)
            cell.viewloadavrTestDuration.Start(value: dobConceptAccuracy ?? 0.0, color: orangeColor)
            
//            cell.lblTotalTimeShow.text = "\(self.statics.value(forKey: "total_time") as? Double ?? 0.0) Hours"
//            cell.lblCorrectRecTimeShow.text = "\(self.statics.value(forKey: "quick_answer") as? Double ?? 0.0) question/ min"
//            cell.lblAvrageTimeShow.text = "\(self.statics.value(forKey: "average_test_duration") as? Double ?? 0.0) minutes/ test"
//
            
            
            

            return cell
        }
            
            else if indexPath.section == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier:
                    "learnigProgressTVCell4") as! learnigProgressTVCell
                
              //  cell.viewMonthPerformance.shadow(UIView: cell.viewMonthPerformance)
             
                return cell
            }

        else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                "learnigProgressTVCell5") as! learnigProgressTVCell
            
            cell.viewMonthPerformance.shadow(UIView: cell.viewMonthPerformance)
         
            return cell
        }
            
        else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                "learnigProgressTVCell6") as! learnigProgressTVCell
            
            return cell
        }
            
        else  {
             let cell = tableView.dequeueReusableCell(withIdentifier: "learnigProgressTVCell7") as! learnigProgressTVCell
            
            cell.viewKeyFocusArea.shadow(UIView: cell.viewKeyFocusArea)
//            cell.barFocusArea.setProgress(50, animated: false)
//            cell.barFocusArea.transform = cell.barFocusArea.transform.scaledBy(x: 1, y: 2)
            let keyFocusAreaDict = self.keyFocusArea[indexPath.row] as? NSDictionary ?? [:]
            print("keyFocusAreaDict is", keyFocusAreaDict)
            
            cell.lblChapNameShow.text = keyFocusAreaDict.value(forKey: "test_name") as? String ?? ""
            cell.lblSroreValueShow.text = keyFocusAreaDict.value(forKey: "test_your_score") as? String ?? ""
            
            let scorePercantage = keyFocusAreaDict.value(forKey: "test_target_score") as? Double ?? 0.0
            let max = 100.0
            let progressValue =  scorePercantage / 100.0
            cell.progressBarScoreShow.setProgress(Float(progressValue), animated: false)
            cell.lblTargetValueShow.text = "\(scorePercantage)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {
            return 390
        }
        else if  indexPath.section == 1{
            return 41
        }
        else if indexPath.section == 2 {
            return 270
        }
        else if indexPath.section == 3 {
            return 40
        }
            else if indexPath.section == 4 {
                return 270
            }
        else if indexPath.section == 5 {
            return 66
        }
        else  {
            return 130
        }
    }
}

///API Performance..

extension learningProgressVC {
    
    func learningPerformanceAPI() {
        
        var Salt = saltMain
        var apiKey = apikeyMain
        var isNewApp = 1
        var action = "syllabus_coverage"
        var UserId = UserDefaults.standard.value(forKey: "USERID")
        var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
        var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
        var studentId = UserDefaults.standard.value(forKey: "CHILDID")
        
        //apiKey:boardId:classId:isNewApp:userId:action:salt
        var checkSumValues =  "\(apiKey):\(BoardId!):\(ClassId!):\(isNewApp):\(UserId!):\(action):\(subjectId!):\(Salt)"
        
        let myCheckString = MD5(checkSumValues)
        print("the chceksum String", checkSumValues)
        print("converted chceksum value ", myCheckString!)
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        // 180:36:1:67710419
        //         AF.request("http://developer.extramarks.com/api/v1.1/subjectwiseprogressreportindo?board_id=\(BoardId!)&class_id=\(ClassId!)&is_new_app=1&user_id=\(UserId!)&report_type=get_subjectwise_report&subject_id=\(subId)&apikey=0DEAD50C6BBA59FF22D33C994&checksum=\(myCheckString!)", method: .get, encoding: JSONEncoding.default, headers: headers)
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("\(baseUrl)v1.1/subjectwiseprogressreportindo?apikey=\(apiKey)&checksum=\(myCheckString!)&board_id=\(BoardId!)&class_id=\(ClassId!)&is_new_app=1&user_id=\(UserId!)&report_type=syllabus_coverage&subject_id=\(subjectId!)", method: .get, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            
                            self.hideActivityIndicator()
                            print("THE JSON RESULT",JSON)
                            
                            let message = JSON["message"] as? String ?? ""
                            print("the message is",message)
                            
                            let responsecode = JSON["response_code"] as?  Int ?? 0
                            if responsecode == 10001 {
                                
                                let dictReport = JSON["report"] as? NSDictionary ?? [:]
                                let progressDict = dictReport.value(forKey: "progress") as? NSDictionary ?? [:]
                                self.subjectDetailDict = progressDict.value(forKey: "subject_detail") as? NSDictionary ?? [:]
                                
                                self.testAdaptive = progressDict.value(forKey: "test_adaptive") as? NSArray ?? []
                                
                                print("test_adaptive is", self.testAdaptive)
                                
                                //test_adaptive
                                self.statics = progressDict.value(forKey: "statics") as? NSDictionary ?? [:]
                                self.keyFocusArea = progressDict.value(forKey: "key_focus_area") as? NSArray ?? []
                                print("keyFocusArea is:- ", self.keyFocusArea)
                                
                            }
                            else {
                                var Message = JSON["message"] as? String ?? ""
                                self.alert(message: Message)
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
