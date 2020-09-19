//
//  detailAnalysisVC.swift
//  Parent EdConnect
//
//  Created by Work on 03/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire
//API9

class detailAnalysisVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var arrSubjectProgress = NSArray()
    var arrRecentlyRakentest = NSArray()
    
//    var subjectNameL:String?
//
//    var syllabusCoveragePercentage:Double?
//        var performancePercentage:Double?


    
//    let max = 10.0
//    let max2 = 100.0
    
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
        
    @IBOutlet weak var viewAlex: UIImageView!
    
    
    @IBOutlet weak var viewSegment: UIView!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func tapBack(_ sender: Any) {
        
 self.navigationController?.backToViewController(viewController: homeScreenVC.self)
    }
    
    @IBAction func tapOverView(_ sender: Any) {
   self.navigationController?.popViewController(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBarSetup()

        if UserId != nil && ClassId != nil && BoardId != nil {
             DetailAPI9()
        }
        else {
            alert(message: "something went wrong")
        }
        
        viewSegment.layer.borderWidth = 1
        viewSegment.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        viewAlex.cornerRadius()
    }
    
   
       override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    
}

 //MARK:- *******-tableViewCycle()-********
 //MARK:-
 extension detailAnalysisVC {
     
     func numberOfSections(in tableView: UITableView) -> Int {
        return 3
     }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
           return arrSubjectProgress.count
        }
        else if section == 1 {
            return 1
        }
        else {
            return arrRecentlyRakentest.count
        }
    }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if indexPath.section == 0 {
                        
             let cell = tableView.dequeueReusableCell(withIdentifier: "detailAnlysisTVCell") as! detailAnlysisTVCell
            
            cell.vewSubject.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
            cell.vewSubject.cornerRadius = 10
            cell.vewSubject.borderWidth = 2

            let dict = self.arrSubjectProgress[indexPath.row] as? NSDictionary ?? [:]

            let previewURL = dict.value(forKey: "icon") as? String ?? ""
            let color = dict.value(forKey: "color") as? String ?? ""
            let subjectName = dict.value(forKey: "subject_name") as? String ?? ""

            let userAvgPerformance = dict.value(forKey: "user_avg_performance") as? Int ?? 0
            let otherUserAvg = dict.value(forKey: "other_user_average") as? Int ?? 0

            let progress = dict.value(forKey: "progress") as? Double ?? 0.0

            cell.imgSubject.sd_setImage(with: URL(string: previewURL))
            cell.imgSubject.backgroundColor = UIColor.init(hexString: color)
            cell.imgSubject.layer.cornerRadius = cell.imgSubject.frame.size.width / 2
            cell.imgSubject.clipsToBounds = true

            cell.lblSubName.text = subjectName
            print("progress1 is",progress)
            
            let progress1 = Double(progress) / 20
            
            let userAvgPerformance1 =  Double(userAvgPerformance) / 100
            print("userAvgPerformance is ",userAvgPerformance)
            
            print("progress1 new is",progress1)
            print("userAvgPerformance1 new is",userAvgPerformance1)
            
            cell.lblSubCoverage.text = "\(progress)"
            cell.lblPerformance.text = "\(userAvgPerformance)"
            
            print("the proresss is",progress)
            print("user Avg Performance is",userAvgPerformance)
            
            cell.barSyllabusCov.setProgress(Float(progress1), animated: true)
            cell.barPrerformance.setProgress(Float(userAvgPerformance1), animated: false)
            return cell
             
         }
         else if indexPath.section == 1 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "detailAnlysisTVCell2") as! detailAnlysisTVCell
            
            if arrRecentlyRakentest.count == 0 {
                cell.isHidden = true
            }
            else {
                 cell.isHidden = false
            }
            
             return cell
         }
         else  {
              let cell = tableView.dequeueReusableCell(withIdentifier: "detailAnlysisTVCell3") as! detailAnlysisTVCell

            let dict2 = self.arrRecentlyRakentest[indexPath.row] as? NSDictionary ?? [:]


            let subjectName = dict2.value(forKey: "subject_name") as? String ?? ""
            let Progress = dict2.value(forKey: "progress") as? Int ?? 0
            let date1 = dict2.value(forKey: "date") as? String ?? ""
            let dynamicLink = dict2.value(forKey: "dynamic_link") as? String ?? ""
            
            let ProgressInD = Double(Progress)
            
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "d MMM yyyy"

            let date: NSDate? = dateFormatterGet.date(from: date1) as NSDate?
            let date2 = dateFormatterPrint.string(from: date! as Date)
            
  
            let score = Double(Progress) / 100
            
            cell.lblRecentSubName.text = subjectName
            cell.lblDate.text = "\(date2)"
            cell.lblDynamicLink.text = dynamicLink
            cell.lblScoreProgress.text = "\(Progress)"
            
            cell.barScore.setProgress(Float(ProgressInD / 100), animated: false)
            cell.viewRecntlyTakenTest.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
            cell.viewRecntlyTakenTest.cornerRadius = 10
            cell.viewRecntlyTakenTest.borderWidth = 2
            return cell
         }
     }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.section == 0 {
             return 134
         }
         else if  indexPath.section == 1{
             return 52
         }
         else {
             return 134
         }
     }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if indexPath.section == 0 {
            
            let dict = self.arrSubjectProgress[indexPath.row] as? NSDictionary ?? [:]
            let subjectName = dict.value(forKey: "subject_name") as? String ?? ""
            let progress = dict.value(forKey: "progress") as? Double ?? 0.0
            let performanceValue = dict.value(forKey: "user_avg_performance") as? Double ?? 0.0
            let subjectId = dict.value(forKey: "id") as? Int ??  0
            print("dict is :-", dict)
            print("the subjectId is",subjectId)
          //  print("the subjectId is",subjectId)
            print("the progress is",progress)

            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
            let VC = storyBoard.instantiateViewController(withIdentifier: "LearningSyllabusCovrateVC") as! LearningSyllabusCovrateVC
            VC.subjectNameL = subjectName
            VC.syllabusCoveragePercentage = progress
            VC.performancePercentage = performanceValue
            VC.subjectIDDetail = subjectId
            
           self.navigationController?.pushViewController(VC, animated: false)
                    
         }
         else if  indexPath.section == 1{
         }
         else {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "MCQLevelResultVC") as! MCQLevelResultVC
            self.navigationController?.pushViewController(VC, animated: false)
                }
    }
 }


extension detailAnalysisVC {

         func  DetailAPI9() {
             
             var isNewApp = 1
             var action = "detailed_analysis"

             var checkSumValues =  "\(apikeyMain):\(BoardId!):\(ClassId!):\(isNewApp):\(UserId!):\(action):\(saltMain)"
             
            
       //apiKey:boardId:classId:isNewApp:userId:action:salt

             let myCheckString = MD5(checkSumValues)
       
             print("the chceksum String", checkSumValues)
             print("converted chceksum value ", myCheckString!)
             
             let headers: HTTPHeaders = [
                 "accept": "application/json",
                 "content-type": "application/json",
             ]
             
             if Reachability.isConnectedToNetwork() {
                 showActivityIndicator()
                 AF.request("http://emstage.extramarks.com/api/v1.1/subjectwiseprogressreportindo?apikey=\(apikeyMain)&checksum=\(myCheckString!)&board_id=\(BoardId!)&class_id=\(ClassId!)&is_new_app=\(isNewApp)&user_id=\(UserId!)&report_type=\(action)", method: .get, encoding: JSONEncoding.default, headers: headers)
                                         
                     .responseJSON { (response) in
                         switch response.result {
                         case .success:
                             if let JSON = response.value as? [String: Any]  {
                                 
                                 self.hideActivityIndicator()
                                 print("THE JSON RESULT",JSON)

                                 let message = JSON["message"] as? String ?? ""
                                 print("the message is",message)
                                 if message == "success" {
                                    self.hideActivityIndicator()

                                    let dictProgressBelajar = JSON["progress_belajar"] as? NSDictionary ?? [:]
                                    
                                    print("dictProgressBelajar is",dictProgressBelajar)
                                    
                                    self.arrSubjectProgress = dictProgressBelajar.value(forKey: "subject_wise_progress") as? NSArray ?? []
                                    
                                    self.arrRecentlyRakentest = dictProgressBelajar.value(forKey: "recently_taken_test") as? NSArray ?? []
                               
                                    print("subjectWiseProgress is",self.arrSubjectProgress)
                                    
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


