//
//  PrfrmnceStOverviewVC.swift
//  Parent EdConnect
//
//  Created by Work on 19/06/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//
import UIKit
import Alamofire
import SDWebImage
//API8

class PrfrmnceStOverviewVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    let i = 67
//    let j = 100
    let max = 10
    
    var dictBriefReport = NSDictionary()
    
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    
    var arrSubjectWiseProgress = NSArray()
    var dictTotalTimeSpent = NSDictionary()
    var dictHighestSub = NSDictionary()
    var dictlowestSub = NSDictionary()
    
    var responseArray = NSArray()
    
     @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var barMyPerfmnce: UIProgressView!
//    @IBOutlet weak var barAvgUserPfrnce: UIProgressView!
//    @IBOutlet weak var lblMiddle1: UILabel!
//    @IBOutlet weak var lblSyllabusCov1: UILabel!
//    @IBOutlet weak var lblTestPerform1: UILabel!
//    @IBOutlet weak var lblGraphRh2: UILabel!
//    @IBOutlet weak var lblGraphMid2: UILabel!
//    @IBOutlet weak var lblGraphLh3: UILabel!
//    @IBOutlet weak var lblGraphRh3: UILabel!
//    @IBOutlet weak var lblGraphMid3: UILabel!
//    @IBOutlet weak var lblGaphLh2: UILabel!
    
    @IBAction func tapDetailAnlysis(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "detailAnalysisVC") as! detailAnalysisVC
        self.navigationController?.pushViewController(VC, animated: false)
    }
    
    
    @IBAction func btnBck(_ sender: Any) {
 self.navigationController?.backToViewController(viewController: homeScreenVC.self)
    }
    
    
    //Mark:- ********__viewCycle_viewDidload_********
    //Mark:-
    override func viewDidLoad() {
        super.viewDidLoad()
          StatusBarSetup()
        
        if UserId != nil && ClassId != nil && BoardId != nil {
            OverviewAPI8()
        }
        else {
            alert(message: "something went wrong")
        }
    }
    
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension PrfrmnceStOverviewVC {
    
    func lblAnim() {
        
//        lblTestPerform1.cropMskToBund()
//        lblSyllabusCov1.cropMskToBund()
//        lblGaphLh2.cropMskToBund()
//        lblGraphLh3.cropMskToBund()
//        lblGraphRh2.cropMskToBund()
//        lblGraphRh3.cropMskToBund()
//
//        lblTestPerform1.gradientYellow()
//        lblSyllabusCov1.gradientYellow()
//        lblMiddle1.gradientYellow()
//        lblGaphLh2.gradientYellow()
//        lblGraphLh3.gradientYellow()
//        lblGraphRh2.gradientYellow()
//        lblGraphRh3.gradientYellow()
//        lblGraphMid2.gradientYellow()
//        lblGraphMid3.gradientYellow()
        
    }
}

//mark:-*************_web_Api_*******
//mark:-

extension PrfrmnceStOverviewVC {
        func  OverviewAPI8() {
            var isNewApp = 1
            var action = "overview"

            
            //apiKey:boardId:classId:isNewApp:userId:action:salt

            
            var checkSumValues =  "\(apikeyMain):\(BoardId!):\(ClassId!):\(isNewApp):\(UserId!):\(action):\(saltMain)"
            
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
//                    AF.request("http://developer.extramarks.com/api/v1.1/subjectwiseprogressreportindo?apikey=0DEAD50C6BBA59FF22D33C994&checksum=8f278bb1bdd9a872c0676e848ee5c74e&board_id=180&class_id=36&is_new_app=1&user_id=14078602&report_type=overview", method: .get, encoding: JSONEncoding.default, headers: headers)
                    
                    .responseJSON { (response) in
                        switch response.result {
                        case .success:
                            if let JSON = response.value as? [String: Any]  {
                                
                                self.hideActivityIndicator()
                                print("THE JSON RESULT 8",JSON)
                                
                                let dic = JSON["question_wise_detail"] as? NSDictionary ?? [:]
                                
                                let message = JSON["message"] as? String ?? ""
                                print("the message is",message)
                                
                                if message == "success" {
                                    
                                    self.hideActivityIndicator()
                                    
                                    self.dictBriefReport = JSON["brief_report"] as? NSDictionary ?? [:]

                                    let dictStatics = self.dictBriefReport.value(forKey: "statics") as? NSDictionary ?? [:]
                                    
                                    let dictInsight = self.dictBriefReport.value(forKey: "insight") as? NSDictionary ?? [:]
                                    
                                    //MARK:-***HIGEST_LOWEST_SCORE_VALUES
                                    //
                                    self.dictHighestSub = dictInsight.value(forKey: "highest_value") as? NSDictionary ?? [:]
                              
                                    self.dictlowestSub = dictInsight.value(forKey: "lowest_value") as? NSDictionary ?? [:]
                                    
                                    
                                    print("dictHighestSub in api is",self.dictHighestSub)
                                    print("dictlowestSub in api is",self.dictlowestSub)
                                 
                                    self.dictTotalTimeSpent = self.dictBriefReport.value(forKey: "total_time_spent") as? NSDictionary ?? [:]
                                    
                                    print("dictTotalTimeSpent isss",self.dictTotalTimeSpent)
                                    
                                    let arrSubject_wise_progress = self.dictlowestSub.value(forKey: "subject_wise_progress") as? NSArray
                                    
                                    print("dictBriefReport in api",self.dictBriefReport)

                                    if arrSubject_wise_progress != nil {
                                        self.arrSubjectWiseProgress = arrSubject_wise_progress!
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

//  @objc func callFunc(){
//
//        let lbl1 = self.view.viewWithTag(101) as! UILabel
//                             lbl1.text = "29 %"
//                             let lbl2 = self.view.viewWithTag(102) as! UILabel
//                                    lbl2.text = "Overall Progress"
//        view.Start(value: 89.9, color: UIColor.red)
//    }


//MARK:- *******-tableViewCycle()-********
//MARK:-
extension PrfrmnceStOverviewVC {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else if section == 1{
            return 1
        }
        else if section == 2{
            
            print("arrSubjectWiseProgress.count in table ",self.arrSubjectWiseProgress.count)
            //return 1
            return self.arrSubjectWiseProgress.count
            
        }
        else if section == 3{
            return 1
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeTVCell") as! homeTVCell
            cell.viewStatictics.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
            cell.viewStatictics.cornerRadius = 10
            cell.viewStatictics.borderWidth = 2
                    
            cell.lblGrph1.cropMskToBund()
            cell.lblGrph2.cropMskToBund()
            cell.lblGrph4.cropMskToBund()
            cell.lblGrph5.cropMskToBund()
            cell.lblGrph7.cropMskToBund()
            cell.lblGrph8.cropMskToBund()
            cell.lblMiddle1.cropMskToBund()
            cell.lblMiddle2.cropMskToBund()
            cell.lblMiddle3.cropMskToBund()
            cell.lblMiddle4.cropMskToBund()
           
            cell.lblGrph1.gradientYellow()
            cell.lblGrph2.gradientYellow()
            cell.lblGrph4.gradientYellow()
            cell.lblGrph5.gradientYellow()
            cell.lblGrph7.gradientYellow()
            cell.lblGrph8.gradientYellow()
            cell.lblGrph3.gradientYellow()
            cell.lblGrph6.gradientYellow()
//            cell.lblAvgUser.gradientYellow()
//            cell.lblMe.gradientYellow()
//            cell.lblTopUser.gradientYellow()
            
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeTVCell2") as! homeTVCell
            return cell
        }
            
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeTVCell3") as! homeTVCell
            let dict = self.arrSubjectWiseProgress[indexPath.row] as? NSDictionary ?? [:]

            // let ratio = Float(i) / Float(max)
            // let ratio2 = Float(j) / Float(max)
            //cell.bar1.transform = cell.bar1.transform.scaledBy(x: 1, y: 2)
            // cell.bar2.transform = cell.bar2.transform.scaledBy(x: 1, y: 2)
            
            let previewURL = dict.value(forKey: "sub_icon") as? String ?? ""
            let color = dict.value(forKey: "color") as? String ?? ""
            let subjectName = dict.value(forKey: "subject_name") as? String ?? ""
            let averageProgress = dict.value(forKey: "average_progress") as? Int ?? 0
            let yourProgress = dict.value(forKey: "your_progress") as? Int ?? 0
            
            let ratio1 = Float(yourProgress) / Float(max)
            let ratio2 = Float(averageProgress) / Float(max)
            
            cell.subImage.sd_setImage(with: URL(string: previewURL))
            cell.subImage.backgroundColor = UIColor.init(hexString: color)
            cell.subImage.layer.cornerRadius = cell.subImage.frame.size.width / 2
            cell.subImage.clipsToBounds = true
            cell.lblSubName.text = subjectName
            cell.lblUrProgress.text = "\(yourProgress)"
            cell.lblAvgProgress.text = "\(averageProgress)"
            cell.bar1.setProgress(ratio1, animated: false)
            cell.bar2.setProgress(ratio2, animated: false)
            
            return cell
        }
            
        else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                "homeTVCell4") as! homeTVCell
                       
            let total_minute = dictTotalTimeSpent.value(forKey: "total_minute") as? Double ?? 0.0
            let speed_accuracy = dictTotalTimeSpent.value(forKey: "speed_accuracy") as? Double ?? 0.0
            let level_accuracy = dictTotalTimeSpent.value(forKey: "level_accuracy") as? Double ?? 0.0
            
            print("speed_accuracy is",speed_accuracy)
            print("level_accuracy",level_accuracy)
            
            
            cell.lblTotalMinutes.text = "\(total_minute) Minutes"
            cell.lblLevelAccuracy.text = "\(level_accuracy) %"
            cell.lblSpeedAccuracy.text = "\(speed_accuracy) min/test"

            cell.viewAccuracyLevel.Start(value: level_accuracy, color: UIColor.orange)
            cell.viewCorrectResponseTime.Start(value: speed_accuracy, color: UIColor.orange)
            
            cell.viewTotalLeaning.gradientBlueWithCornerRadius()
            
            

            return cell
        }
            
        else  {
             let cell = tableView.dequeueReusableCell(withIdentifier: "homeTVCell5") as! homeTVCell
            print("dictBriefReport is",self.dictBriefReport)
            let higestSub = self.dictHighestSub.value(forKey: "subject_name") as? String ?? ""
            let higestSubIcon = self.dictHighestSub.value(forKey: "subject_icon") as? String ?? ""
            let higestScore = self.dictHighestSub.value(forKey: "score") as? String ?? ""
            
            let lowestSub = self.dictlowestSub.value(forKey: "subject_name") as? String ?? ""
            let lowestSubIcon = self.dictlowestSub.value(forKey: "subject_icon") as? String ?? ""
            let lowestScore = self.dictlowestSub.value(forKey: "score") as? String ?? ""

            
            
            cell.lblHigestScoreSub.text = higestSub
            cell.lblHigestScore.text = higestScore
            //cell.imgHigestScoreSub.sd_setImage(with: URL(string: higestSubIcon))
            cell.lblLowestScoresSub.text = lowestSub
            cell.lblLowestScore.text = lowestScore
           // cell.imgLowestScore.sd_setImage(with: URL(string: lowestSubIcon))
            
            let higestSubUrl = URL.init(string: higestSubIcon)
            let lowestSubUrl = URL.init(string: lowestSubIcon)
            
            print("higestSubUrl is",higestSubUrl)
            print("lowestSubUrl is",lowestSubUrl)
            

            if higestSubUrl != nil {
                cell.imgLowestScore.loadUrl(url: higestSubUrl!)
            }
            if lowestSubUrl != nil {
                cell.imgLowestScore.loadUrl(url: lowestSubUrl!)
                
            }
            
            
            cell.imgHigestScoreSub.layer.cornerRadius = cell.imgHigestScoreSub.frame.size.width / 2
            cell.imgLowestScore.layer.cornerRadius = cell.imgLowestScore.frame.size.width / 2
            
            
            print("higestSub is",higestSub)
            print("lowestSub is",lowestSub)
            print("higestSubIcon is",higestSubIcon)
            print("lowestSubIcon is",lowestSubIcon)
            print("dictHighestSub is",self.dictHighestSub)
            print("dictlowestSub is",self.dictlowestSub)
            
            cell.viewHigestSub.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
            cell.viewHigestSub.cornerRadius = 10
            cell.viewHigestSub.borderWidth = 2
            cell.viewLowestSub.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
            cell.viewLowestSub.cornerRadius = 10
            cell.viewLowestSub.borderWidth = 2
            
            cell.tapHighestScoreSub.addTarget(self, action: #selector(tapHighestScoreSubClicked(_:)), for: .touchUpInside)
                      cell.tapHighestScoreSub.tag = indexPath.row

            
            cell.tapLowestScoreSub.addTarget(self, action: #selector(tapLowestScoreSubClicked(_:)), for: .touchUpInside)
            cell.tapLowestScoreSub.tag = indexPath.row
               return cell
        }
    }
    
    @objc func tapHighestScoreSubClicked(_ sender:UIButton){
        let VC =
            self.storyboard?.instantiateViewController(withIdentifier: "hIghLowestScoreVC") as! hIghLowestScoreVC
        VC.screenName = "0"
        VC.subDict = self.dictHighestSub
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @objc func tapLowestScoreSubClicked(_ sender:UIButton){
        let VC =
            self.storyboard?.instantiateViewController(withIdentifier: "hIghLowestScoreVC") as! hIghLowestScoreVC
        VC.screenName = "1"
        VC.subDict = self.dictlowestSub
        self.navigationController?.pushViewController(VC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 202
        }
        else if  indexPath.section == 1{

            return 60
        }
        else if indexPath.section == 2 {
            return 67
        }
        else if indexPath.section == 3 {
            return 258
        }
        else {
            return 276
        }
    }
}

extension UIImageView {
    
    func loadUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
                
            }
        }
    }
    
}
