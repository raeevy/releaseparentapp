//
//  StructureOfAtomsVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/8/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire

class StructureOfAtomsVC: UIViewController {
    
    
    @IBOutlet weak var lblHeadingChapName: UILabel!
    @IBOutlet weak var viewOverViewContents: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblOverView: UILabel!
    @IBOutlet weak var viewCircalView: UIView!
    @IBOutlet weak var lblScoreShow: UILabel!
    @IBOutlet weak var lblPersentageOverViewShow: UILabel!
    @IBOutlet weak var lblTakenTaskValue: UILabel!
    @IBOutlet weak var lblTakenTask: UILabel!
    @IBOutlet weak var lblCorrectAnsValue: UILabel!
    @IBOutlet weak var lblCorrectAns: UILabel!
    @IBOutlet weak var lblWrongAnsValue: UILabel!
    @IBOutlet weak var lblWrongAns: UILabel!
    @IBOutlet weak var lblSkpiedValue: UILabel!
    @IBOutlet weak var lbllblSkpiedQus: UILabel!
    @IBOutlet weak var lblTimeQusValue: UILabel!
    @IBOutlet weak var lblTimeQus: UILabel!
    @IBOutlet weak var viewAccurencyContents: UIView!
    @IBOutlet weak var lblAccurancyValuesOutOf: UILabel!
    @IBOutlet weak var lblAccurencyPercentageShow: UILabel!
    @IBOutlet weak var accurencyProgress: UIProgressView!
    @IBOutlet weak var btnAnswerKeys: UIButton!
    @IBOutlet weak var viewEvaluationContents: UIView!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var viewCircualTimeTaken: CircularView!
    @IBOutlet weak var lblTimeTaken: UILabel!
    @IBOutlet weak var lblTimeShowTimeTaken: UILabel!
    @IBOutlet weak var viewCircularAnsSpeed: CircularView!
    @IBOutlet weak var lblAnsSpeed: UILabel!
    @IBOutlet weak var lblTimeQusAnsSpeed: UILabel!
    @IBOutlet weak var viewDifficultyWiseAnalysis: UIView!
    @IBOutlet weak var lblEasy: UILabel!
    @IBOutlet weak var lblMedium: UILabel!
    @IBOutlet weak var lblDifficult: UILabel!
    @IBOutlet weak var lblCorrect: UILabel!
    @IBOutlet weak var lblWrong: UILabel!
    @IBOutlet weak var lblSkiped: UILabel!
    @IBOutlet weak var graphCircularViewG: CircularArc!
    @IBOutlet weak var keyForceTableView: UITableView!{
        didSet {
            self.keyForceTableView.delegate = self
            self.keyForceTableView.dataSource = self
        }
    }
    
    ///Values By Previse Screen.
    var dictDataP:NSDictionary?
    
    //    var correctAnswers:Int?
    //    var incorrectAnswers:Int?
    //    var skippedQuestions:Int?
    //    var overallProgress:Double?
    var chapNameRecently:String?
    var subjestId:Int?
    var chapterId:String?
    var testId:String?
    
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    
    var overViewDict = NSDictionary()
    var totalTestsTaken:Int?
    var accuracy:Double?
    
    var evaluationDict = NSDictionary()
    var averageTimeTaken:Double?
    var averageAnswerSpeed:Double?
    var totalTime:Int?
    
    var easyQuestionAnalysisDict = NSDictionary()
    var totalCorrect:String?
    var totalWrong:String?
    var totalSkipped:String?
    var difficultQuestionAnalysis = NSDictionary()
    var mediumQuestionAnalysis = NSDictionary()
    var keyFocusareArr = NSArray()
    
    
    ///Mark:-Status Bar Change
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    ///MARK:- View Life Cycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StatusBarSetup()
        self.keyForceTableView.reloadData()
        self.SetupUI()
        self.StatusBarSetup()
        lblHeadingChapName.text = self.chapNameRecently
        if BoardId != nil && ClassId != nil && UserId != nil && subjestId != nil && subjestId != nil &&  testId != nil {
            self.subWisePerformaceaAtomAPI()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    ///Mark:- UI Customization .
    func SetupUI()  {
        btnAnswerKeys.btnGradientCrop(UIButton: btnAnswerKeys)
        self.viewAccurencyContents.gradientBlueWithCornerRadius()
        self.viewEvaluationContents.gradientBlueWithCornerRadius()
        self.viewOverViewContents.shadow(UIView: viewOverViewContents)
        self.viewDifficultyWiseAnalysis.shadow(UIView: viewDifficultyWiseAnalysis)
    }
    ///Mark:- Button Actions.
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapAnswerKeys(_ sender: UIButton) {
        
        //        let storyBord = UIStoryboard(name: "Home", bundle: nil)
        //        let VC = storyBord.instantiateViewController(withIdentifier: "MCQScoreDetailVC") as! MCQScoreDetailVC
        //        self.navigationController?.pushViewController(VC, animated: true)
        
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "answerKeyGtsVC") as! answerKeyGtsVC
        VC.screenCheck = 4
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}

///MARK:- Table View DataSorce and DataSorces.
extension StructureOfAtomsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.keyFocusareArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:StructureOfAtomsKeyForceTVC = tableView.dequeueReusableCell(withIdentifier: "StructureOfAtomsKeyForceTVC") as! StructureOfAtomsKeyForceTVC else { return UITableViewCell() }
        
        let dictKeyFocusareArr = self.keyFocusareArr[indexPath.row] as? NSDictionary ?? [:]
        cell.lblKeySubName.text = dictKeyFocusareArr.value(forKey: "tpoic_name") as? String ?? ""
        let scoreP = dictKeyFocusareArr.value(forKey: "score_percentage") as? String ?? ""
        let targetV = dictKeyFocusareArr.value(forKey: "test_target_score") as? Double ?? 0.0
        cell.lblShowScore.text = scoreP
        cell.lblTargetShow.text = "\(targetV)"
        let stringConvertInt = Double(scoreP) ?? 0.0
        let spaceValue = stringConvertInt / 100.0
        cell.progressBar.setProgress(Float(spaceValue), animated: false)
        //        "topic_id": "559241",
        
        return cell
        
    }
    
}


extension StructureOfAtomsVC {
    //API 11.
    func subWisePerformaceaAtomAPI() {
        var Salt = saltMain
        var apiKey = apikeyMain
        var isNewApp = 1
        var action = "get_chapterwise_report"
        
        
        //   boardId : classId :  isNewApp  :   userId  :  action :   subjectId :   chapterId :  API_KEY :   testId  : SALT
        
        
        var checkSumValues =  "\(BoardId!):\(ClassId!):\(isNewApp):\(UserId!):\(action):\(subjestId!):\(chapterId!):\(apiKey):\(testId!):\(Salt)"
        
        
        let myCheckString = MD5(checkSumValues)
        print("the chceksum String", checkSumValues)
        print("converted chceksum value ", myCheckString!)
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("\(baseUrl)v1.1/subjectwiseprogressreportindo?board_id=\(BoardId!)&class_id=\(ClassId!)&is_new_app=1&user_id=\(UserId!)&report_type=get_chapterwise_report&subject_id=\(subjestId!)&chapter_id=\(chapterId!)&apikey=\(apiKey)&checksum=\(myCheckString!)&test_id=\(testId!)", method: .get, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            
                            self.hideActivityIndicator()
                            print("THE JSON RESULT",JSON)
                            
                            let message = JSON["message"] as? String ?? ""
                            print("the message is",message)
                            
                            //self.userId = JSON["userId"] as? String ?? ""
                            
                            let responsecode = JSON["response_code"] as?  Int ?? 0
                            if responsecode == 10001 {
                                
                                self.keyFocusareArr = JSON["key_focus_area"] as?  NSArray ?? []
                                print("keyFocusareArr is",self.keyFocusareArr)
                                
                                self.overViewDict = JSON["overview"] as? NSDictionary ?? [:]
                                print("overViewDict is:-", self.overViewDict)
                                
                                
                                self.totalTestsTaken = self.overViewDict.value(forKey: "total_tests_taken") as? Int
                                
                                let correctAnswers = self.dictDataP?.value(forKey: "correct_answers") as? String ?? ""
                                let incorrectAnswers = self.dictDataP?.value(forKey: "incorrect_answers") as? String ?? ""
                                let skippedQuestions = self.dictDataP?.value(forKey: "skipped_questions") as? String ?? ""
                                
                                let correctAnswers2 = self.dictDataP?.value(forKey: "correct_answers") as? Int ?? 0
                                let incorrectAnswers2 = self.dictDataP?.value(forKey: "incorrect_answers") as? Int ?? 0
                                let skippedQuestions2 = self.dictDataP?.value(forKey: "skipped_questions") as? Int ?? 0
                                
                                self.accuracy = self.overViewDict.value(forKey: "accuracy") as? Double ?? 0.0
                                
                                let correctIntValue = Int(correctAnswers) ?? 0
                                let inCorrectIntValue = Int(incorrectAnswers) ?? 0
                                let skippedQuestionsValue = Int(skippedQuestions) ?? 0
                                
                                self.lblTakenTaskValue.text = "\(self.totalTestsTaken ?? 0)"
                                self.lblCorrectAnsValue.text = "\(correctAnswers)"
                                self.lblWrongAnsValue.text = "\(incorrectAnswers)"
                                self.lblSkpiedValue.text = "\(skippedQuestions)"
                                self.lblTimeQusValue.text = "\(correctAnswers)"
                                
                                var arcArray: [Arc] = [Arc]()
                                arcArray.append(Arc(c: #colorLiteral(red: 0.4033602476, green: 0.8931822777, blue: 0.6872150898, alpha: 1), v: Double(correctIntValue)))
                                arcArray.append(Arc(c: #colorLiteral(red: 0.9218646884, green: 0.4113363922, blue: 0.4478791952, alpha: 1), v: Double(inCorrectIntValue)))
                                arcArray.append(Arc(c: #colorLiteral(red: 0.5921034217, green: 0.5921911597, blue: 0.592084229, alpha: 1), v: Double(skippedQuestionsValue)))
                                self.graphCircularViewG.Start(array: arcArray, lWidth: 8.0)
                                
                                let overallProgress = self.dictDataP?.value(forKey: "overall_progress") as? Double ?? 0.0
                                
                                let max = 100.0
                                let progressValue =  overallProgress / 100.0
                                self.accurencyProgress.setProgress(Float(progressValue), animated: false)
                                
                                let perc = self.dictDataP?.value(forKey: "overall_progress") as? Double ?? 0.0
                                let myIntValue = Int(overallProgress)
                                self.lblPersentageOverViewShow.text = "\(myIntValue)"
                                self.lblAccurencyPercentageShow.text = "\(myIntValue)%"
                                
                                self.evaluationDict = JSON["evaluation"] as? NSDictionary ?? [:]
                                print("evaluationDict is:-", self.evaluationDict)
                                
                                self.averageTimeTaken = self.evaluationDict.value(forKey: "average_time_taken") as? Double ?? 0.0
                                self.averageAnswerSpeed = self.evaluationDict.value(forKey: "average_answer_speed") as? Double ?? 0.0
                                self.lblTimeQusAnsSpeed.text = "\(self.averageAnswerSpeed ?? 0.0) minutes/ question"
                                self.totalTime = self.evaluationDict.value(forKey: "total_time") as? Int ?? 0
                                self.lblTimeShowTimeTaken.text = "\(self.totalTime ?? 0)"
                                
                                self.viewCircualTimeTaken.Start(value: self.averageTimeTaken ?? 0, color: UIColor.orange)
                                self.viewCircularAnsSpeed.Start(value: self.averageAnswerSpeed ?? 0 , color: UIColor.orange)
                              
            
                                self.easyQuestionAnalysisDict = JSON["easy_question_analysis"] as? NSDictionary ?? [:]
                                
                                self.totalCorrect = self.easyQuestionAnalysisDict.value(forKey: "totalCorrect") as? String ?? ""
                                self.totalWrong = self.easyQuestionAnalysisDict.value(forKey: "total_wrong") as? String ?? ""
                                
                                self.totalSkipped = self.easyQuestionAnalysisDict.value(forKey: "total_skipped") as? String ?? ""
                                
                                self.difficultQuestionAnalysis = JSON["difficult_question_analysis"] as? NSDictionary ?? [:]
                                self.mediumQuestionAnalysis = JSON["medium_question_analysis"] as? NSDictionary ?? [:]
                                
                                print("easy_question_analysis is :- ", self.easyQuestionAnalysisDict)
                                
                                
                            }
                            else {
                                
                            }
                            self.keyForceTableView.reloadData()
                            
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
