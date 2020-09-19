//
//  LearningSyllabusCovrateVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/3/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire

class LearningSyllabusCovrateVC: UIViewController {
    
    @IBOutlet weak var viewContainerHeightConstrants: NSLayoutConstraint!
    @IBOutlet weak var ViewCustomHeightsUpper: NSLayoutConstraint!
    @IBOutlet weak var customHeightConstrantTV: NSLayoutConstraint!
    @IBOutlet weak var lblSubName: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewSelectedBtnSyllabus: UIView!
    @IBOutlet weak var viewPerformancrSellect: UIView!
    @IBOutlet weak var btnSyllabus: UIButton!
    @IBOutlet weak var btnPerformance: UIButton!
    @IBOutlet weak var lblProgressShowTop: UILabel!
    @IBOutlet weak var lblMyScorePercentageTop: UILabel!
    @IBOutlet weak var lblBestUserShow: UILabel!
    @IBOutlet weak var viewCircalProcess: UIView!
    @IBOutlet weak var progressBarLiner: UISlider!
    @IBOutlet weak var lblLearnPercentageShow: UILabel!
    @IBOutlet weak var lblPrecticePercentageShow: UILabel!
    @IBOutlet weak var viewLearnCircal: CircularArc!
    @IBOutlet weak var viewPracticeCircal: CircularArc!
    
    @IBOutlet weak var viewUpperLearn: UIView!
    
    @IBOutlet weak var viewUpperPractice: UIView!
    
    @IBOutlet weak var viewSyllabusCoverd: CustomView!
    @IBOutlet weak var lblSyllabusCovered: UILabel!
    @IBOutlet weak var lblBasedONLPT: UILabel!
    @IBOutlet weak var listTableView: UITableView!{
        didSet {
            self.listTableView.delegate = self
            self.listTableView.dataSource = self
        }
    }
    @IBOutlet weak var lblContentCunTotalHours: UILabel!
    @IBOutlet weak var viewCoustomGraphShow: CustomView!
    @IBOutlet weak var viewGraphShow: UIView!
    @IBOutlet weak var viewMeUser: CustomView!
    @IBOutlet weak var viewBestUser: CustomView!
    
    
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var subjectIDDetail:Int?
    var arrMasterOfMaterials = NSArray()
    var arrContentConsumption = NSArray()
    var subjectNameL:String?
    var syllabusCoveragePercentage:Double?
    var performancePercentage:Double?
    
    
    //MARK:- Button Actions.
    @IBAction func btnBck(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapPrformace(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "learningProgressVC") as! learningProgressVC
        VC.subjectId = self.subjectIDDetail
        VC.subNameCov = self.subjectNameL
        VC.performancePercentagePerformance = self.performancePercentage
        self.navigationController?.pushViewController(VC, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StatusBarSetup()
        self.listTableView.rowHeight = UITableView.automaticDimension
      //  self.ViewCustomHeightsUpper.constant = 100
        
        self.viewBestUser.layer.cornerRadius = 11
        self.viewMeUser.layer.cornerRadius = 11
        self.lblSubName.text = self.subjectNameL
        print("subjectIDDetail is:-", subjectIDDetail!)
        let valueInt = Int(self.syllabusCoveragePercentage ?? 0.0)
        self.lblProgressShowTop.text = "\(valueInt)%"
        self.lblMyScorePercentageTop.text =  "\(valueInt)%"
        
        if BoardId != nil && ClassId != nil && UserId != nil {
            learningSyllabusCovrateVCAPI()
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.viewCircalProcess.gradientBlueWithCornerRadius()
        //self.viewUpperPractice.gradientBlueWithCornerRadius()
        //self.viewUpperLearn.gradientBlueWithCornerRadius()
      //  self.viewLearnCircal.gradientBlueWithCornerRadius()
      //  self.viewPracticeCircal.gradientBlueWithCornerRadius()
    }
    ///Mark:-Status Bar Change
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension LearningSyllabusCovrateVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMasterOfMaterials.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LearningSyllabusCoveredTVCell = listTableView.dequeueReusableCell(withIdentifier: "LearningSyllabusCoveredTVCell") as! LearningSyllabusCoveredTVCell
        
        let dictArrMasterOfMaterials = self.arrMasterOfMaterials[indexPath.row] as? NSDictionary ?? [:]
        
        cell.lblSyllabusName.text = dictArrMasterOfMaterials.value(forKey: "material_name") as? String ?? ""
        
        let scorePercantage = dictArrMasterOfMaterials.value(forKey: "material_progress") as? Double ?? 0.0
        let max = 100.0
        let progressValue =  scorePercantage / 100.0
        cell.progressBar.setProgress(Float(progressValue), animated: false)
        cell.lblShowPercentageValue.text = "\(scorePercantage)%"
    //    self.viewPracticeCircal.Start
      //  cell.viewloadCorrectRespTime.Start(value: dobTotalAccuracy ?? 0.0, color: orangeColor)

        
        return cell
    }
    
}

////API SyllabusCoverage .
extension LearningSyllabusCovrateVC {
    
    func learningSyllabusCovrateVCAPI() {
        
        var Salt = saltMain
        var apiKey = apikeyMain
        var isNewApp = 1
        var action = "syllabus_coverage"
        var UserId = UserDefaults.standard.value(forKey: "USERID")
        var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
        var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
        var studentId = UserDefaults.standard.value(forKey: "CHILDID")
        
        //apiKey:boardId:classId:isNewApp:userId:action:salt
        
        var checkSumValues =  "\(apiKey):\(BoardId!):\(ClassId!):\(isNewApp):\(UserId!):\(action):\(subjectIDDetail!):\(Salt)"
        let myCheckString = MD5(checkSumValues)
        
        print("the chceksum String 34", checkSumValues)
        print("converted chceksum value ", myCheckString!)
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("\(baseUrl)v1.1/subjectwiseprogressreportindo?apikey=\(apiKey)&checksum=\(myCheckString!)&board_id=\(BoardId!)&class_id=\(ClassId!)&is_new_app=1&user_id=\(UserId!)&report_type=syllabus_coverage&subject_id=\(subjectIDDetail!)", method: .get, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                            print("THE JSON RESULT 34",JSON)
                            let message = JSON["message"] as? String ?? ""
                            print("the message is",message)
                            
                            let responsecode = JSON["response_code"] as?  Int ?? 0
                            if responsecode == 10001 {
                                
                                let dictReport = JSON["report"] as? NSDictionary ?? [:]
                                let dictSyllabusCoverage = dictReport.value(forKey: "syllabus_coverage") as? NSDictionary ?? [:]
                                let dictSyllabusDetail = dictSyllabusCoverage.value(forKey: "syllabus_detail")
                                    as? NSDictionary ?? [:]
                                
                                let userProgress = dictSyllabusDetail.value(forKey: "user_progress") as? Double ?? 0.0
                                self.progressBarLiner.setValue(Float(userProgress), animated: false)
                                
                                //                                let value = dictSyllabusDetail.value(forKey: "user_progress") as? Double ?? 0.0
                                //                                let floatValue = Int(value)
                                //                                self.lblProgressShowTop.text = "\(dictSyllabusDetail.value(forKey: "user_progress") as? Double ?? 0.0)%"
                                
                                let myScorValue = dictSyllabusDetail.value(forKey: "average_progress") as? Double ?? 0.0
                                
                            //    self.lblMyScorePercentageTop.text = "\(dictSyllabusDetail.value(forKey: "average_progress") as? Double ?? 0.0)"
                                self.lblBestUserShow.text = "\(dictSyllabusDetail.value(forKey: "other_progress") as? Double ?? 0.0)"
                                
                                let learnPercentage = dictSyllabusDetail.value(forKey: "learn") as? Double ?? 0.0
                                let precticePercentage = dictSyllabusDetail.value(forKey: "practice") as? Double ?? 0.0
                                
                                let remainingSpace = 100 - learnPercentage
                                let remainingSpacePrectice = 100 - precticePercentage
        
                                var arcArray: [Arc] = [Arc]()
                                arcArray.append(Arc(c: #colorLiteral(red: 0.968627451, green: 0.5843137255, blue: 0.003921568627, alpha: 1), v: Double(learnPercentage ?? 0)))
                                arcArray.append(Arc(c: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), v: Double(remainingSpace ?? 0)))
                               self.viewLearnCircal.Start(array: arcArray, lWidth: 6.0)

                                var arcArrayPrectice: [Arc] = [Arc]()
                                arcArrayPrectice.append(Arc(c: #colorLiteral(red: 0.968627451, green: 0.5843137255, blue: 0.003921568627, alpha: 1), v: Double(precticePercentage ?? 0)))
                                arcArrayPrectice.append(Arc(c: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), v: Double(remainingSpacePrectice ?? 0)))
                                self.viewPracticeCircal.Start(array: arcArrayPrectice, lWidth: 6.0)
                        
                                self.lblLearnPercentageShow.text = "\(dictSyllabusDetail.value(forKey: "learn") as? Double ?? 0.0)"
                                self.lblPrecticePercentageShow.text = "\(dictSyllabusDetail.value(forKey: "practice") as? Double ?? 0.0)"
                                
                                self.arrMasterOfMaterials = dictSyllabusCoverage.value(forKey: "master_of_materials") as? NSArray ?? []
                                self.arrContentConsumption = dictSyllabusCoverage.value(forKey: "content_consumption") as? NSArray ?? []
                                
                                //For Custom TV Heights.
                                self.customHeightConstrantTV.constant = self.listTableView.contentSize.height
                                let arrCount:Int = self.arrMasterOfMaterials.count ?? 1
                                print("arrCount is :-", arrCount)
                                self.customHeightConstrantTV.constant = CGFloat(47 * arrCount)
   
                            }
                            else {
                                var Message = JSON["message"] as? String ?? ""
                                self.alert(message: Message)
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
