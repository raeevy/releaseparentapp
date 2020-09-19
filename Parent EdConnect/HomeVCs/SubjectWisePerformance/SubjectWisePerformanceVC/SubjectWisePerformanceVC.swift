//
//  SubjectWisePerformanceVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/7/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire

class SubjectWisePerformanceVC: UIViewController {
    
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    var studentId = UserDefaults.standard.value(forKey: "CHILDID")
    var subId:Int?
    var subjectName:String?
    var arrRecentlyTakenTest = NSArray()
    let cellSpacingHeight: CGFloat = 1
    var arrChapterWisePerformance = NSArray()
    var chapterName:String?
    var chapterId:Int?
    var coverage:Double?
    var performance:Double?
    var learnCoveragePercentage:String?
    var mcqPassPercentageAverage:Double?
    var adaptiveScore:Int?
    var practiceCoveragePercentage:String?
    var keyFocusArea = NSArray()
    

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var listTableView: UITableView!{
        didSet {
            self.listTableView.dataSource = self
            self.listTableView.delegate = self
        }
    }
    ///Mark:-Status Bar Change
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    ///MARK:- View Life Cycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StatusBarSetup()
        self.listTableView.rowHeight = UITableView.automaticDimension
        if BoardId != nil && ClassId != nil && UserId != nil && subId != nil && subId != nil{
            subWisePerformaceaAPI()
        }
        listTableView.register(UINib.init(nibName: "SubjectWPChapterWiseTVC", bundle: nil), forCellReuseIdentifier: "SubjectWPChapterWiseTVC")
          listTableView.register(UINib.init(nibName: "RecentlyTakenTestTVC", bundle: nil), forCellReuseIdentifier: "RecentlyTakenTestTVC")
          listTableView.register(UINib.init(nibName: "KeyFoarceAreALabelTVC", bundle: nil), forCellReuseIdentifier: "KeyFoarceAreALabelTVC")
        listTableView.register(UINib.init(nibName: "KeyFocusAreaXIBTVC", bundle: nil), forCellReuseIdentifier: "KeyFocusAreaXIBTVC")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    @IBAction func didTapbackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func moveTONextAnalyess(){
        let storyBord = UIStoryboard(name: "Home", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "SubjectWiseAnalysisVC") as! SubjectWiseAnalysisVC

        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @objc func moveTONextVC(){
           let storyBord = UIStoryboard(name: "Home", bundle: nil)
           let VC = storyBord.instantiateViewController(withIdentifier: "StructureOfAtomsVC") as! StructureOfAtomsVC
           self.navigationController?.pushViewController(VC, animated: true)
           
       }
    
}

///MARK:- Table View DataSorce and DataSorces.
extension SubjectWisePerformanceVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return self.keyFocusArea.count
                    
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return UITableView.automaticDimension

        case 2:
            return 60
        case 3:
            return 175

        default:
            return 0
        }

    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
             guard let cell:SubjectWPChapterWiseTVC = tableView.dequeueReusableCell(withIdentifier: "SubjectWPChapterWiseTVC") as? SubjectWPChapterWiseTVC else { return UITableViewCell() }
             cell.parentVC = self
             cell.arrChapterWisePerformanceCell = self.arrChapterWisePerformance
             //For Custom TV Heights.
             cell.customHeightConstrantCWP.constant = cell.chapterWiseSubXIBCell.contentSize.height
             let arrCount:Int = self.arrChapterWisePerformance.count ?? 1
             print("arrCountChapterWP is :-", arrCount)
             cell.customHeightConstrantCWP.constant = CGFloat(75 * arrCount)
             
             cell.chapterWiseSubXIBCell.reloadData()

                return cell
        case 1:
            guard let cell:RecentlyTakenTestTVC = tableView.dequeueReusableCell(withIdentifier: "RecentlyTakenTestTVC") as? RecentlyTakenTestTVC else { return UITableViewCell() }
            cell.parentVC = self
            cell.arrResentlyTakenTestCell = self.arrRecentlyTakenTest
            //For Custom TV Heights.
            cell.customHeightsContrantsTV.constant = cell.xibTableResentlyTT.contentSize.height
            let arrCount:Int = self.arrRecentlyTakenTest.count ?? 1
            print("arrCountRecently is :-", arrCount)
            cell.customHeightsContrantsTV.constant = CGFloat(103 * arrCount)
            cell.subId = self.subId
            cell.xibTableResentlyTT.reloadData()
            
                return cell
        case 2:
             guard let cell:KeyFoarceAreALabelTVC = tableView.dequeueReusableCell(withIdentifier: "KeyFoarceAreALabelTVC") as? KeyFoarceAreALabelTVC else { return UITableViewCell() }
                return cell
        case 3:
             guard let cell:KeyFocusAreaXIBTVC = tableView.dequeueReusableCell(withIdentifier: "KeyFocusAreaXIBTVC") as? KeyFocusAreaXIBTVC else { return UITableViewCell() }
             
             let dictKey = self.keyFocusArea[indexPath.row] as? NSDictionary ?? [:]
             cell.lblKeySubName.text = dictKey.value(forKey: "chapter_name") as? String ?? ""
             let scoreP = dictKey.value(forKey: "score_percentage") as? Double ?? 0.0
             let targetV = dictKey.value(forKey: "test_target_score") as? Double ?? 0.0
             cell.lblShowScore.text = "\(scoreP)"
             cell.lblTargetShow.text = "\(targetV)"
            // let maxValue = targetV
             let spaceValue = scoreP / 100.0
             cell.progressBar.setProgress(Float(spaceValue), animated: false)
           
                return cell
        default:
            
            let cell = UITableViewCell()
            return cell
            
        }
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        switch indexPath.section {
////        case 0:
////            print("section 0")
////        case 1:
////           print("section 1")
////
////        case 2:
//////            let storyBord = UIStoryboard(name: "Home", bundle: nil)
//////            let VC = storyBord.instantiateViewController(withIdentifier: "StructureOfAtomsVC") as! StructureOfAtomsVC
//////            self.navigationController?.pushViewController(VC, animated: true)
////
////            print("section 1")
////        case 3:
////            print("section 3")
////
////        default:
////            print("section 4")
////        }
//        let storyBord = UIStoryboard(name: "Home", bundle: nil)
//                  let VC = storyBord.instantiateViewController(withIdentifier: "StructureOfAtomsVC") as! StructureOfAtomsVC
//                  self.navigationController?.pushViewController(VC, animated: true)
//    }
    
}

///MARK:- API Call.
extension SubjectWisePerformanceVC {
    //API 10.
    func subWisePerformaceaAPI() {
        //p@rentapp$android@!2019
        //0DEAD50C6BBA59FF22D33C994
        var Salt = saltMain
        var apiKey = apikeyMain
        var isNewApp = 1
        var action = "get_subjectwise_report"
   
        //boardId:classId:isNewApp:userId:action:subjectId:API_KEY:SALT
        var checkSumValues =  "\(BoardId!):\(ClassId!):\(isNewApp):\(UserId!):\(action):\(subId!):\(apiKey):\(Salt)"

                let myCheckString = MD5(checkSumValues)
                print("the chceksum String", checkSumValues)
                print("converted chceksum value ", myCheckString!)
                
                let headers: HTTPHeaders = [
                    "accept": "application/json",
                    "content-type": "application/json",
                ]
                
                if Reachability.isConnectedToNetwork() {
                    showActivityIndicator()
      
                    AF.request("\(baseUrl)v1.1/subjectwiseprogressreportindo?board_id=\(BoardId!)&class_id=\(ClassId!)&is_new_app=1&user_id=\(UserId!)&report_type=get_subjectwise_report&subject_id=\(subId!)&apikey=\(apiKey)&checksum=\(myCheckString!)", method: .get, encoding: JSONEncoding.default, headers: headers)
          
                        .responseJSON { (response) in
                            switch response.result {
                            case .success:
                                if let JSON = response.value as? [String: Any]  {
                                    
                                    self.hideActivityIndicator()
                                    print("THE JSON RESULT 10",JSON)

                                    let message = JSON["message"] as? String ?? ""
                                    print("the message is",message)
                                    
                                    let responsecode = JSON["response_code"] as?  Int ?? 0
                                    if responsecode == 10001 {
                                        
                                        self.arrRecentlyTakenTest = JSON["recently_taken_test"] as?  NSArray ?? []
                                        print("arrRecentlyTakenTest is ", self.arrRecentlyTakenTest)
               
                                        self.arrChapterWisePerformance = JSON["chapter_wise_performance"] as? NSArray ?? []
                                        print("arrChapterWisePerformance is ", self.arrChapterWisePerformance)

                                        ///For Key Focus Area .
                                        self.keyFocusArea = JSON["key_focus_area"] as? NSArray ?? []
                                        print("key_focus_area is ", self.keyFocusArea)
                                        
                                        
                                    }
                                  else {
                                            
                                    }
                                    self.listTableView.reloadData()
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
