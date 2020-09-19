//
//  MCQLevelResultVC.swift
//  Parent EdConnect
//
//  Created by Work on 02/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire

class MCQLevelResultVC: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    var chapterName:String?
    var subID = 177
    var testID = 25728
      
    @IBOutlet weak var viewGraphLoader: CircularArc!
    @IBOutlet weak var lblChapterName: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblCorrectAns: UILabel!
    @IBOutlet weak var lblWrongAns: UILabel!
    @IBOutlet weak var lblTotalTime: UILabel!
    @IBOutlet weak var lblAccuracy: UILabel!
    @IBOutlet weak var lblMinPerQues: UILabel!
    @IBOutlet weak var lblSkippedQues: UILabel!
    @IBOutlet weak var viewAccuracy: UIView!
    @IBOutlet weak var viewEvaluation: UIView!
    @IBOutlet weak var viewOverview: UIView!
    @IBOutlet weak var btnAnswerKey: UIButton!
    @IBOutlet weak var viewBarChart: UIView!
    @IBOutlet weak var loader1: CircularView!
    @IBOutlet weak var loader2: CircularView!
    @IBAction func tapAnswerKey(_ sender: Any) {
        
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
//        let VC = storyBoard.instantiateViewController(withIdentifier: "MCQScoreDetailVC") as! MCQScoreDetailVC
//               self.navigationController?.pushViewController(VC, animated: true)
        
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "answerKeyGtsVC") as! answerKeyGtsVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBarSetup()
        helperFunctions()
      
        API37()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if chapterName != nil {
            lblChapterName.text = chapterName!
        }
    }
    
    ///Mark:-Status Bar Change
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension MCQLevelResultVC{
    func helperFunctions() {
        btnAnswerKey.btnGradientCrop(UIButton: btnAnswerKey)
        viewOverview.shadow(UIView: viewOverview)
        viewEvaluation.gradientBlueWithCornerRadius()
        viewAccuracy.gradientBlueWithCornerRadius()
        viewBarChart.shadow(UIView: viewBarChart)
        
    }
}


extension MCQLevelResultVC {
//    func CircleProgressBar() {
//
//
//        let center = CGPoint (x: viewBarChart.frame.size.width / 2, y: viewBarChart.frame.size.height / 2)
//
//        let circleRadius = viewBarChart.frame.size.width / 2
//
//
//        let trackLayer = CAShapeLayer()
//
//        let circularPath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
//
//             trackLayer.path = circularPath.cgPath
//
//             trackLayer.strokeColor = UIColor.lightGray.cgColor
//             trackLayer.lineWidth = 8
//             trackLayer.fillColor = UIColor.clear.cgColor
//             trackLayer .lineCap = CAShapeLayerLineCap.round
//
//        view.layer.addSublayer(trackLayer)
//
//
//
//        shapeLayer.path = circularPath.cgPath
//
//        shapeLayer.strokeColor = UIColor.yellow.cgColor
//        shapeLayer.lineWidth = 10
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.lineCap = CAShapeLayerLineCap.round
//        shapeLayer.strokeEnd = 0
//        view.layer.addSublayer(shapeLayer)
//
//        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        basicAnimation.toValue = 1
//
//        basicAnimation.duration = 2
//
//       // basicAnimation.fillMode = kCAFillModeForward
//        basicAnimation.isRemovedOnCompletion = false
//
//
//        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
//    }
}

 
//MARK:- ********Web_Api******
//MARK:- api:37
extension MCQLevelResultVC {
    func  API37() {
        
        var UserId = UserDefaults.standard.value(forKey: "USERID")
        var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
        var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
        var isNewApp = 1
        var Salt = saltMain
        var apiKey = apikeyMain
        var action = "test_list_all"
        
        let checkSumValues =  "\(UserId!):\(ClassId!):\(subID):\(testID):\(isNewApp):\(action):\(apiKey):\(BoardId!):\(Salt)"
        let myCheckString = MD5(checkSumValues)
    
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        

        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            
            AF.request("\(baseUrl)api/v1.1/subjectwiseprogressreportindo?user_id=\(UserId!)&class_id=\(ClassId!)&subject_id=\(subID)&test_id=\(testID)&is_new_app=1&report_type=test_details&apikey=\(apikeyMain)&board_id=\(BoardId!)&checksum=\(myCheckString!)", method: .get, encoding: JSONEncoding.default, headers: headers)
           // AF.request("http://developer.extramarks.com/api/v1.1/subjectwiseprogressreportindo?user_id=67567001&class_id=36&subject_id=177&test_id=25728&is_new_app=1&report_type=test_details&apikey=0DEAD50C6BBA59FF22D33C994&board_id=180&checksum=8e02aa0bb8d36d08fbf8eda38dd2aebb", method: .get, encoding: JSONEncoding.default, headers: headers)
                
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            
                            self.hideActivityIndicator()
                            print("THE JSON RESULT",JSON)
                            
                            let answer_keys = JSON["answer_keys"] as? NSDictionary ?? [:]
                            let evaluation = JSON["evaluation"] as? NSDictionary ?? [:]
                                
                            let score_percantage = JSON["score_percantage"] as? Int ?? 0
                            let correctAns = JSON["correct_question_count"] as? Int ?? 0
                            let wrongAns = JSON["wrong_answer"] as? Int ?? 0
                            let skipped = JSON["skipped"] as? Int ?? 0
                           
                            self.lblScore.text = "\(score_percantage)"
                            self.lblCorrectAns.text = "\(correctAns)"
                            self.lblWrongAns.text = "\(wrongAns)"
                            self.lblSkippedQues.text = "\(skipped)"
                            

                            var arcArray: [Arc] = [Arc]()
                            arcArray.removeAll()
                            arcArray.append(Arc(c: #colorLiteral(red: 0.4033602476, green: 0.8931822777, blue: 0.6872150898, alpha: 1), v: Double(correctAns) ))
                            arcArray.append(Arc(c: #colorLiteral(red: 0.9218646884, green: 0.4113363922, blue: 0.4478791952, alpha: 1), v: Double(wrongAns)))
                            arcArray.append(Arc(c: #colorLiteral(red: 0.5921034217, green: 0.5921911597, blue: 0.592084229, alpha: 1), v: Double(skipped)))
                            print("after ararray",arcArray)
                            self.viewGraphLoader.Start(array: arcArray, lWidth: 8.0)
                            
                            
                            let totalTime = evaluation.value(forKey: "total_time") as? String ?? ""
                            let totalAccuracy = evaluation.value(forKey: "total_accuracy") as? String ?? ""
                            let conceptAccuracy = evaluation.value(forKey: "concept_accuracy") as? String ?? ""
                          
                            self.lblTotalTime.text = totalTime
                            self.lblAccuracy.text = "\(totalAccuracy) "
                            self.lblMinPerQues.text = "\(conceptAccuracy) min/quesion"
                            
                            let dobTotalAccuracy = Double(totalAccuracy)
                            let dobConceptAccuracy = Double(conceptAccuracy)
                            
                            self.loader1.Start(value: dobTotalAccuracy ?? 0.0, color: orangeColor)
                            self.loader2.Start(value: dobConceptAccuracy ?? 0.0, color: orangeColor)
                            
                         
                            let all = JSON["all"] as? NSArray ?? []
                                
                                print("answer_keys is",answer_keys)
                                print("evaluation",evaluation)
                                print("all is",all)
                      
                            
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

//cell.barTopicProgress.setProgress(ratio1, animated: false)
//cell.barTopicProgress.transform =
//    cell.barTopicProgress.transform.scaledBy(x: 1, y: 2)
