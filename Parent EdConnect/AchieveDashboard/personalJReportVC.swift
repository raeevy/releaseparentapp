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

    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    var studentId = UserDefaults.standard.value(forKey: "CHILDID")
    
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
        
        viewtable.borderColor = #colorLiteral(red: 0.8626691699, green: 0.862793684, blue: 0.8626419902, alpha: 1)
        viewtable.cornerRadius = 10
        viewtable.borderWidth = 2
        self.StatusBarSetup()
        
        personalizedJourneyReportApi()
        viewSegment.shadow(UIView: viewSegment)
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
       
    }
    
    @IBAction func btnMaths(_ sender: Any) {
        
        btnMaths.setTitleColor(#colorLiteral(red: 0.14805004, green: 0.3711644709, blue: 0.764950335, alpha: 1), for: .normal)
        lblMaths.backgroundColor = #colorLiteral(red: 0.9449529648, green: 0.5010166168, blue: 0.2282519341, alpha: 1)
        
        lblEnglish.backgroundColor = .clear
        btnEnglish.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        
        lblScience.backgroundColor = .clear
        btnScience.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
      
    }
    
    
    @IBAction func btnEnglish(_ sender: Any) {
        
        btnEnglish.setTitleColor(#colorLiteral(red: 0.14805004, green: 0.3711644709, blue: 0.764950335, alpha: 1), for: .normal)
        lblEnglish.backgroundColor = #colorLiteral(red: 0.9449529648, green: 0.5010166168, blue: 0.2282519341, alpha: 1)
        
        lblScience.backgroundColor = .clear
        btnScience.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        
        lblMaths.backgroundColor = .clear
        btnMaths.setTitleColor(#colorLiteral(red: 0.5646545291, green: 0.5647386909, blue: 0.5646362305, alpha: 1), for: .normal)
        
    }
    
   
}

 //MARK:- *******-tableViewCycle()-********
 //MARK:-
 extension personalJReportVC {
     
     func numberOfSections(in tableView: UITableView) -> Int {
        return 2
     }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
           return 1
        }
        else {
            return 1

        }
    }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if indexPath.section == 0 {
                        
             let cell = tableView.dequeueReusableCell(withIdentifier: "PJReportTVCell") as! PJReportTVCell
            

        
             return cell
         }
       
         else  {
              let cell = tableView.dequeueReusableCell(withIdentifier: "PJReportTVCell2") as! PJReportTVCell

                return cell
         }
     }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.section == 0 {
             return 65
         }
         else {
             return 43
         }
     }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if indexPath.section == 0 {
            
         }
        
         else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
            let VC = storyBoard.instantiateViewController(withIdentifier: "evaluatedWorksheetVC") as! evaluatedWorksheetVC
            self.navigationController?.pushViewController(VC, animated: true)
            
        }
    }
 }
//http://developer.extramarks.com/api/v1.1/subjectwiseprogressreportindo?board_id=180&class_id=36&is_new_app=1&user_id=67567001&report_type=get_personalized_journey_report&subject_id=&apikey=0DEAD50C6BBA59FF22D33C994&checksum=01896bf4857f47607e28283363604b98


//
//mark:-*************_web_Api_*******
//mark:-
extension personalJReportVC {
        func  personalizedJourneyReportApi() {
            var Salt = "p@rentapp$ios@!2019"
            var apiKey = "8DDAD308E555C2AA38BFF8DBE"
            var isNewApp = 1
            var reportType = "get_personalized_journey_report"
 
            
//   CheckSum Sequence:
//   boardId : classId : isNew App : studentId : report_type : “” : apiKey : salt

            

            var checkSumValues =  "\(BoardId):\(ClassId!):\(isNewApp):\(studentId!):\(reportType):\(""):\(apiKey):\(Salt)"
            
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
                AF.request("http://developer.extramarks.com/api/v1.1/subjectwiseprogressreportindo?board_id=180&class_id=36&is_new_app=1&user_id=67567001&report_type=get_personalized_journey_report&subject_id=&apikey=0DEAD50C6BBA59FF22D33C994&checksum=01896bf4857f47607e28283363604b98", method: .get, encoding: JSONEncoding.default, headers: headers)
                    
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
