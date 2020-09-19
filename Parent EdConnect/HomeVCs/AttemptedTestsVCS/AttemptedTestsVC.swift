//
//  AttemptedTestsVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/6/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire


class AttemptedTestsVC: UIViewController {
    
    @IBOutlet weak var lblSubNameOnTop: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnChapterTest: UIButton!
    @IBOutlet weak var btnConceptTest: UIButton!
    @IBOutlet weak var btnMCT: UIButton!
    @IBOutlet weak var btnSort: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var lblChapterLine: UILabel!
    @IBOutlet weak var lblConceptLine: UILabel!
    @IBOutlet weak var lblMCTLine: UILabel!
    @IBOutlet weak var dataListTableView: UITableView! {
        didSet {
            self.dataListTableView.delegate = self
            self.dataListTableView.dataSource = self
        }
    }
    
    public var currentSelectedIndex = 0
    var chapterTest: String?
    var arrChapterTest = NSArray()
    var arrQuickTest = NSArray()
    var arrMCT = NSArray()
    var mcqLevelStatus1:String?
    var mcqLevelStatus2:String?
    var mcqLevelStatus3:String?
    var adaptiveTestStatus:String?
    
    var arrMCQLevelStatus1 = NSArray()
    var arrMCQLevelStatus2 =  NSArray()
    var arrMCQLevelStatus3 = NSArray()
    var arrAdaptiveTestStatus = NSArray()
    var arrTestDetails = NSArray()
    var subNameCov:String?
    var subID:Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBarSetup()
        apiViewTestAttempts()
        self.lblSubNameOnTop.text = self.subNameCov
        self.dataListTableView.register(UINib.init(nibName: "ChapterTestTableViewCell", bundle: nil), forCellReuseIdentifier: "ChapterTestTableViewCell")
        
      //  self.dataListTableView.register(UINib.init(nibName: "ChapterXIB2TableViewCell", bundle: nil), forCellReuseIdentifier: "ChapterXIB2TableViewCell")
        
        self.dataListTableView.register(UINib.init(nibName: "ConceptTestTableViewCell", bundle: nil), forCellReuseIdentifier: "ConceptTestTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if currentSelectedIndex == 0 {
            self.didTapChapterTestBtn(UIButton())
        } else if currentSelectedIndex == 1{
            self.didTapConceptTestBtn(UIButton())
        } else {
            self.didTapMCTBtn(UIButton())
        }
    }
    
    ///Mark:-Status Bar Change
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func currentSection(type: String) {
        if type == "1" {
            chapterTest = "Chapter Test"
            
        } else if type == "2" {
            chapterTest = "Concept Test"
            
        } else {
            chapterTest = "MCT"
        }
    }
    
    @objc func ComeBack(_ sender:UIButton){
        let storyBord = UIStoryboard(name: "Home", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "ViewMoreVC") as! ViewMoreVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    ///MARK:- Button Actions.
    
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapChapterTestBtn(_ sender: UIButton) {
        lblMCTLine.backgroundColor = UIColor.white
        lblConceptLine.backgroundColor = UIColor.white
        lblChapterLine.backgroundColor = UIColor.blue
        btnChapterTest.setTitleColor(UIColor.blue , for: .normal)
        btnConceptTest.setTitleColor(UIColor.lightGray , for: .normal)
        btnMCT.setTitleColor(UIColor.lightGray , for: .normal)
        self.currentSection(type: "1")
        self.dataListTableView.reloadData()
        
    }
    
    @IBAction func didTapConceptTestBtn(_ sender: UIButton) {
        lblMCTLine.backgroundColor = UIColor.white
        lblConceptLine.backgroundColor = UIColor.blue
        lblChapterLine.backgroundColor = UIColor.white
        btnChapterTest.setTitleColor(UIColor.lightGray , for: .normal)
        btnConceptTest.setTitleColor(UIColor.blue , for: .normal)
        btnMCT.setTitleColor(UIColor.lightGray , for: .normal)
        self.currentSection(type: "2")
        self.dataListTableView.reloadData()
    }
    
    @IBAction func didTapMCTBtn(_ sender: UIButton) {
        lblMCTLine.backgroundColor = UIColor.blue
        lblConceptLine.backgroundColor = UIColor.white
        lblChapterLine.backgroundColor = UIColor.white
        btnChapterTest.setTitleColor(UIColor.lightGray , for: .normal)
        btnConceptTest.setTitleColor(UIColor.lightGray , for: .normal)
        btnMCT.setTitleColor(UIColor.blue , for: .normal)
        self.currentSection(type: "3")
        self.dataListTableView.reloadData()
    }
    
    @IBAction func didTapSortBtn(_ sender: UIButton) {
        let storyBord = UIStoryboard(name: "Home", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "ApplySortViewController") as! ApplySortViewController
        self.navigationController?.present(VC, animated: true, completion: nil)
        
    }
    
    @IBAction func didTapFilterBtn(_ sender: UIButton) {
        let storyBord = UIStoryboard(name: "Home", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "ApplyFilterChapterTestVC") as! ApplyFilterChapterTestVC
        self.navigationController?.present(VC, animated: true, completion: nil)
    }
}

extension AttemptedTestsVC : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if chapterTest == "Chapter Test" {
            switch section {
            case 0:
                
//                if self.arrChapterTest.count <= 1 {
//                    return self.arrChapterTest.count
//                }
//                return 1
                
                 return self.arrChapterTest.count
                
//            case 1:
//                return self.arrChapterTest.count
            default:
                return 0
            }
        } else if chapterTest == "Concept Test" {
            return self.arrQuickTest.count
            
            print("arrQuickTest is:- " , self.arrQuickTest.count)
            
        } else {
            return self.arrMCT.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if chapterTest == "Chapter Test" {
            switch indexPath.section {
            case 0:
                
//                let firstIndex = self.arrChapterTest.firstObject as? Int ?? 0
//                if indexPath.row == firstIndex {
//
//                    return 500
//                } else {
//                    return 187.5
//                }
                
                return 350
//            case 1:
//                return 110
                
            default:
                return 0
            }
        } else if chapterTest == "Concept Test" {
            return 170
        } else {
            return 140
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if chapterTest == "Chapter Test" {
            switch indexPath.section {
            case 0:
                guard  let cell:ChapterTestTableViewCell = dataListTableView.dequeueReusableCell(withIdentifier: "ChapterTestTableViewCell") as? ChapterTestTableViewCell else {return UITableViewCell() }
             
                cell.viewContents.shadow(UIView: cell.viewContents)
                //   cell.btnShowMore.addTarget(self, action: #, for: <#T##UIControl.Event#>)
                
                if arrMCQLevelStatus1.count >= 2 || arrMCQLevelStatus2.count >= 2 || arrMCQLevelStatus3.count >= 2 || arrAdaptiveTestStatus.count >= 2 {
                    cell.btnShowMore.addTarget(self, action: #selector(ComeBack(_:)), for: .touchUpInside)
                } else{
                    print("Its Less Then 2 , Sorry I can't Move")
                }
                
//                let firstIndex = self.arrChapterTest.firstObject as? Int ?? 0
//                if indexPath.row == firstIndex {
//
//                    cell.viewCustomHeightContrants.constant = 312.5
//                } else {
//                    cell.viewCustomHeightContrants.constant = 0
//                }
                
                
                let arrChapterTestDict = arrChapterTest[indexPath.row] as? NSDictionary ?? [:]
                
              //  print("arrChapterTestDict is", arrChapterTestDict)
                cell.lblHeadingName.text = arrChapterTestDict.value(forKey: "chapter_name") as? String ?? ""
                let scorePercantage = arrChapterTestDict.value(forKey: "average_performance") as? Double ?? 0.0
                let max = 100.0
                let progressValue =  scorePercantage / 100.0
                cell.prograshBar.setProgress(Float(progressValue), animated: false)
                
                let valueInt = Int(scorePercantage)
                cell.lblOverallProgresShow.text = "\(valueInt)%"
                
                self.mcqLevelStatus1 = arrChapterTestDict.value(forKey: "mcq_level1_status") as? String ?? ""
                self.mcqLevelStatus2 = arrChapterTestDict.value(forKey: "mcq_level2_status") as? String ?? ""
                self.mcqLevelStatus3 = arrChapterTestDict.value(forKey: "mcq_level3_status") as? String ?? ""
                self.adaptiveTestStatus = arrChapterTestDict.value(forKey: "adaptive_test_status") as? String ?? ""
                self.arrMCQLevelStatus1 = arrChapterTestDict.value(forKey: "mcq_level1") as? NSArray ?? []
                self.arrMCQLevelStatus2 = arrChapterTestDict.value(forKey: "mcq_level2") as? NSArray ?? []
                self.arrMCQLevelStatus3 = arrChapterTestDict.value(forKey: "mcq_level3") as? NSArray ?? []
                self.arrAdaptiveTestStatus = arrChapterTestDict.value(forKey: "adaptive_test") as? NSArray ?? []
                cell.mcqL1DictCell = self.arrMCQLevelStatus1
                cell.mcqL2DictCell = self.arrMCQLevelStatus2
                cell.mcqL3DictCell = self.arrMCQLevelStatus3
                cell.adeptiveDictCell = self.arrAdaptiveTestStatus
                
                
                return cell
                
//            case 1:
//                guard let cell:ChapterXIB2TableViewCell = dataListTableView.dequeueReusableCell(withIdentifier: "ChapterXIB2TableViewCell") as? ChapterXIB2TableViewCell else { return UITableViewCell() }
//                cell.viewContents.shadow(UIView: cell.viewContents)
//
//
//                 let arrChapterTestDict1 = arrChapterTest[indexPath.row] as? NSDictionary ?? [:]
//                cell.lblItemNameType.text = arrChapterTestDict1.value(forKey: "chapter_name") as? String ?? ""
//                let percentageProcess = arrChapterTestDict1.value(forKey: "average_performance") as? Double ?? 0.0
//                cell.progressBar.setProgress(Float(percentageProcess), animated: true)
//                cell.lblShowOverallProgress.text = arrChapterTestDict1.value(forKey: "average_performance") as? String ?? ""
//
//
//                return cell
            default:
                let cell = UITableViewCell()
                return cell
                
            }
            
        } else if chapterTest == "Concept Test" {
            
            guard let cell:ConceptTestTableViewCell = dataListTableView.dequeueReusableCell(withIdentifier: "ConceptTestTableViewCell") as? ConceptTestTableViewCell else { return UITableViewCell() }
            
            cell.viewContents.shadow(UIView: cell.viewContents)
            cell.imgNextArrow.isHidden = true
            
            let arrTestDetailsDict = self.arrTestDetails[indexPath.row] as? NSDictionary ?? [:]
            
            print("arrTestDetailsDict is:-", arrTestDetailsDict)
            
            let scorePercantage = arrTestDetailsDict.value(forKey: "score_percantage") as? Double ?? 0.0
            let max = 100.0
            let progressValue =  scorePercantage / 100.0
            cell.progressSrore.setProgress(Float(progressValue), animated: false)
            
            let valueInt = Int(scorePercantage)
            cell.lblShowScore.text = "\(valueInt)/10"
          //  cell.lblShowScore.text = "\(scorePercantage)/10"
            cell.lblTestType.text = arrTestDetailsDict.value(forKey: "testtype") as? String ?? ""
        
        
            return cell
            
            
        } else {
            
            guard let cell:ConceptTestTableViewCell = dataListTableView.dequeueReusableCell(withIdentifier: "ConceptTestTableViewCell") as? ConceptTestTableViewCell else { return UITableViewCell() }
            cell.viewContents.shadow(UIView: cell.viewContents)
            cell.imgNextArrow.isHidden = false
            
            let arrMCTDict = self.arrMCT[indexPath.row] as? NSDictionary ?? [:]
            cell.lblAttempedChapterName.text = arrMCTDict.value(forKey: "chapter_name") as? String ?? ""
            
            let scorePercantage = arrMCTDict.value(forKey: "score_percantage") as? Double ?? 0.0
            let max = 100.0
            let progressValue =  scorePercantage / 100.0
            cell.progressSrore.setProgress(Float(progressValue), animated: false)
            
            let valueInt = Int(scorePercantage)
            cell.lblShowScore.text = "\(valueInt)/10"
         //   cell.lblShowScore.text = "\(scorePercantage)/100"
          
            
            let attemedChapName = "Attempt " + (arrMCTDict.value(forKey: "total_questions") as? String ?? "")
            cell.lblAttempedChapterName.text = "\(attemedChapName)"
            
            let attemedChapNameAtt = arrMCTDict.value(forKey: "Chapters") as? String ?? ""
            cell.lblChaptersValue.text = "(\(attemedChapNameAtt) Chapters)"
            
          //  let chapterName = arrMCTDict.value(forKey: "chapter_name") as? String ?? ""
            
            let datevalue = arrMCTDict.value(forKey: "test_date") as? String ?? ""
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "d MMM yyyy"

            let date: NSDate? = dateFormatterGet.date(from: datevalue) as NSDate?
            cell.lblTestType.text = dateFormatterPrint.string(from: date! as Date)
            

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if chapterTest == "Chapter Test" {
            
        }
        else if chapterTest == "Concept Test" {
        }
        else {
            let arrMCTDict = self.arrMCT[indexPath.row] as? NSDictionary ?? [:]
            let chapterName = arrMCTDict.value(forKey: "chapter_name") as? String ?? ""
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let VC = storyBoard.instantiateViewController(withIdentifier: "MCQLevelResultVC") as! MCQLevelResultVC
            VC.chapterName = chapterName
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}


//MARK:- ********_Web_Api_Call_******
//MARK:- apiViewTestAttempts API 36.
extension AttemptedTestsVC {
    func  apiViewTestAttempts() {
        var Salt = saltMain
        var apiKey = apikeyMain
        var isNewApp = 1
        var action = "test_list_all"
        var UserId = UserDefaults.standard.value(forKey: "USERID")
        var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
        var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
        var studentId = UserDefaults.standard.value(forKey: "CHILDID")
        
      
         var checkSumValues =  "\(UserId!):\(ClassId!):\(subID!):\(isNewApp):\(action):\(apiKey):\(BoardId!):\(Salt)"
        let myCheckString = MD5(checkSumValues)
        
        print("the chceksum String 34", checkSumValues)
        print("converted chceksum value ", myCheckString!)
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("\(baseUrl)v1.1/subjectwiseprogressreportindo?user_id=\(UserId!)&class_id=\(ClassId!)&subject_id=\(subID!)&is_new_app=1&report_type=test_list_all&apikey=\(apiKey)&board_id=\(BoardId!)&checksum=\(myCheckString!)", method: .get, encoding: JSONEncoding.default, headers: headers)
                
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            
                            self.hideActivityIndicator()
                            print("THE JSON RESULT",JSON)
                            
                            let status = JSON["status"] as? Int ?? 0
                            print("the status is",status)
                            
                            if status == 1 {
                                self.hideActivityIndicator()
                        
                                self.arrChapterTest = JSON["chapter_test"] as? NSArray ?? []
                                self.arrQuickTest = JSON["quick_test"] as? NSArray ?? []
                                
                                self.arrTestDetails = self.arrQuickTest.value(forKey: "test_details") as? NSArray ?? []
                                
                                print("arrTestDetails Qamar is ", self.arrTestDetails)
                                
                                self.arrMCT = JSON["mct"] as? NSArray ?? []
                                print("arrMCT Qamar is ", self.arrMCT)
                                
                            }
                            else {
                                var Message = JSON["message"] as? String ?? ""
                                self.alert(message: Message)
                            }
                            
                            self.dataListTableView.reloadData()
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
