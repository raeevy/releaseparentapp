//
//  testWiseAnlysis.swift
//  Parent EdConnect
//
//  Created by Work on 11/08/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire
import Highcharts

//API:40 weekly-test > subject > attempted = test_Wise_analysis

class testWiseAnlysis: UIViewController, UITableViewDataSource, UITabBarDelegate {
    
    let i = 67
    let max = 10
    var ansScreencheck:Int?
    var weeklyTestID:Int?
    
    var autoID:String?
    var quesStatus:Int?
    
    var arrRight = NSMutableArray()
    var arrWrong = NSMutableArray()
    var arrSkipped = NSMutableArray()
    var arrTimeTaken = NSMutableArray()
    
    var reviseChapter = NSArray()
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    
    @IBOutlet weak var viewOverView: CustomView!
    @IBOutlet weak var viewGraphLoader: CircularArc!
    @IBOutlet weak var circleLoaderTimeTaken: CircularView!
    @IBOutlet weak var circleLoaderAnswerSpeed: CircularView!
    @IBOutlet weak var dataTable: UITableView!
    @IBOutlet weak var viewEvaluate: UIView!
    @IBOutlet weak var barProgress: UIProgressView!
    @IBOutlet weak var viewAccuray: UIView!
    @IBOutlet weak var btnAnswerKey: UIButton!
    @IBOutlet weak var lblCorrectAns: UILabel!
    @IBOutlet weak var lblWrongAns: UILabel!
    @IBOutlet weak var lblSkippedQues: UILabel!
    @IBOutlet weak var lblTotalQues: UILabel!
    @IBOutlet weak var lblTotalAttempted: UILabel!
    @IBOutlet weak var lblTimeTaken: UILabel!
    @IBOutlet weak var lblAnswerSpeed: UILabel!
    @IBOutlet weak var lblAccuracyText: UILabel!
    @IBOutlet weak var lblAccuracyPercent: UILabel!
    @IBOutlet weak var bullet1: UIView!
    @IBOutlet weak var bullet2: UIView!
    @IBOutlet weak var bullet3: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataTable.rowHeight = UITableView.automaticDimension
        dataTable.register(UINib.init(nibName: "TestWiseAnlysisTVCXib", bundle: nil), forCellReuseIdentifier: "TestWiseAnlysisTVCXib")
        
        loadUI()
        if ansScreencheck == 3 {
            API40()
        }
        else {
            API15()
        }
        self.StatusBarSetup()
    }
    //Status bar content
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAnswerKey(_ sender: Any) {
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "answerKeyGtsVC") as! answerKeyGtsVC
        VC.screenCheck = ansScreencheck
        VC.weeklytestId = autoID
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

extension testWiseAnlysis {
    func loadUI() {
        // var C = #colorLiteral(red: 0.07639399029, green: 0.1929807574, blue: 0.6887373709, alpha: 1)
        // var C1 = #colorLiteral(red: 0.2023790777, green: 0.4098873734, blue: 0.9161154628, alpha: 1)
        
        viewAccuray.gradientBlue2()
        viewEvaluate.gradientBlueWithCornerRadius()
        bullet1.layer.cornerRadius = bullet1.frame.size.width / 2
        bullet1.clipsToBounds = true
        bullet2.layer.cornerRadius = bullet2.frame.size.width / 2
        bullet2.clipsToBounds = true
        bullet3.layer.cornerRadius = bullet3.frame.size.width / 2
        bullet3.clipsToBounds = true
        btnAnswerKey.gradientYellow()
        btnAnswerKey.layer.cornerRadius = 10.0
        btnAnswerKey.layer.masksToBounds = true;
        
        let ratio = Float(i) / Float(max)
        barProgress.transform = barProgress.transform.scaledBy(x: 1, y: 2)
        barProgress.setProgress(ratio, animated: false)
        
        viewOverView.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        viewOverView.cornerRadius = 10
        viewOverView.borderWidth = 2
        
    }
}


//MARK:- *******-tableViewCycle()-********
//MARK:-
extension testWiseAnlysis {
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
            return 1
        }
        else if section == 3{
            return 1
        }
        else {
            return reviseChapter.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //  let cell = tableView.dequeueReusableCell(withIdentifier: "testWiseTVCell") as! testWiseTVCell
            guard let cell:TestWiseAnlysisTVCXib = tableView.dequeueReusableCell(withIdentifier: "TestWiseAnlysisTVCXib") as? TestWiseAnlysisTVCXib else { return UITableViewCell() }
            
            cell.viewContents.shadow(UIView: cell.viewContents)
            
            
            //            let ratio = Float(i) / Float(max)
            //            let ratio1 = Float(ratio) / Float(max)
            //
            //            cell.barTopicProgress.setProgress(ratio1, animated: false)
            //            cell.barTopicProgress.transform =  cell.barTopicProgress.transform.scaledBy(x: 1, y: 2)
            
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "testWiseTVCell1") as! testWiseTVCell
            return cell
        }
            
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "testWiseTVCell2") as! testWiseTVCell
            
            
            let chart = HIChart()
            chart.type = "bar"
            
            let title = HITitle()
            title.text = "Historic World Population by Region"
            
            let subtitle = HISubtitle()
            subtitle.text = "Source: <a href=\"https://en.wikipedia.org/wiki/World_population\">Wikipedia.org</a>"
            
            let xaxis = HIXAxis()
            xaxis.categories = ["1", "2", "3", "4"]
            
            let yaxis = HIYAxis()
            yaxis.min = NSNumber(value: 0)
            yaxis.title = HITitle()
            yaxis.title.text = "time"
            yaxis.title.align = "high"
            yaxis.labels = HILabels()
            yaxis.labels.overflow = "justify"
            
            let tooltip = HITooltip()
            tooltip.valueSuffix = "millions"
            
            let plotOptions = HIPlotOptions()
            plotOptions.bar = HIBar()
            //        plotOptions.bar.dataLabels = HIDataLabels()
            //        plotOptions.bar.dataLabels.enabled = NSNumber(value: true)
            
            var legend = HILegend()
            legend.layout = "vertical"
            legend.align = "right"
            legend.verticalAlign = "top"
            legend.x = NSNumber(value: -40)
            legend.y = NSNumber(value: 80)
            legend.floating = NSNumber(value: true)
            legend.borderWidth = NSNumber(value: 1)
            legend.backgroundColor = HIColor(hexValue: "FFFFFF")
            //legend.shadow = NSNumber(value: true)
            
            let credits = HICredits()
            credits.enabled = NSNumber(value: false)
            
            let bar1 = HIBar()
            bar1.color = HIColor(rgba: 76, green: 216, blue: 154, alpha: 1)
            //bar1.data = arrRight as! [Any]
            bar1.data = [6,4,2]
            
            //            rgba(76, 216, 154, 1)
            
            let bar2 = HIBar()
            bar2.color = HIColor(rgba: 240, green: 88, blue: 110, alpha: 1)
            // bar2.data = arrWrong as! [Any]
            bar2.data = [2,4,6]
            
            //            rgba(240, 88, 110, 1)
            
            let bar3 = HIBar()
            bar3.color = HIColor(rgba: 153, green: 153, blue: 153, alpha: 1) //gray
            //            bar3.data = arrSkipped as! [Any]
            bar3.data = [4,6,2]
            
            
            let options = HIOptions()
            options.chart = chart
            options.title = title
            options.subtitle = subtitle
            options.xAxis = [xaxis]
            options.yAxis = [yaxis]
            options.tooltip = tooltip
            options.plotOptions = plotOptions
            //            options.legend = legend
            options.credits = credits
            options.series = [bar1,bar2,bar3]
            cell.barChartView.options = options
            
            cell.viewDiffcultyWiseAnalysis.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
            cell.viewDiffcultyWiseAnalysis.cornerRadius = 10
            cell.viewDiffcultyWiseAnalysis.borderWidth = 2
            
            return cell
        }
            
        else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                "testWiseTVCell3") as! testWiseTVCell
            return cell
        }
            
        else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "testWiseTVCell4") as! testWiseTVCell
            
            
            let dict = self.reviseChapter[indexPath.row] as? NSDictionary ?? [:]
            
            let chapterName = dict.value(forKey: "chapter_name") as? String ?? ""
            let percentage = dict.value(forKey: "percentage") as? String ?? ""
            let idleTime = dict.value(forKey: "idle_time") as? String ?? ""
            let timeTaken = dict.value(forKey: "time_taken") as? String ?? ""
            let chapterId = dict.value(forKey: "chapter_id") as? String ?? ""
            
            cell.lblChapterName.text = chapterName
            cell.lblIdeleAndTakenTime.text = " Ideal Time: \(idleTime) min | Time Taken: \(timeTaken) min"
            cell.lblPercentage.text = "\(percentage)%"
            
            let dbPercentage = Double(percentage) ?? 0.0
            
            //Ideal Time: 15 min | Time Taken: 5 Min
            if percentage != "0" {
                var arcArray: [Arc] = [Arc]()
                arcArray.append(Arc(c: #colorLiteral(red: 0.9523274302, green: 0.5835757852, blue: 0.2794597745, alpha: 1), v: dbPercentage))
                cell.viewGraphLoader.Start(array: arcArray, lWidth: 4.0)
            }
            
            cell.viewReviseChapter.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
            cell.viewReviseChapter.cornerRadius = 10
            cell.viewReviseChapter.borderWidth = 2
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0 {
            return 1
            //UITableView.automaticDimension
        }
        else if  indexPath.section == 1{
            
            return 42
        }
        else if indexPath.section == 2 {
            return 510
        }
        else if indexPath.section == 3 {
            return 41
        }
        else {
            return 100
        }
    }
}

//MARK:-*********_WebaApiCall_**********
//MARK:- API15()

extension testWiseAnlysis {
    func API15() {
        
        var Action = "test_wise_analysis"
        var studentType = 2
        var apiKey = apikeyMain
        var salt = saltMain
        var PaperType = "10"
        
        let checkSumValues =  "\(weeklyTestID!):\(UserId!):\(studentType):\(Action):\(PaperType):\(saltMainLMS):\(apikeyMainLMS)"
        var uparcaseChecksum = checkSumValues.uppercased()
        let myChecksum = MD5(uparcaseChecksum)
        
        let postData = [
            "action":Action,
            "checksum":myChecksum,
            "language_code":"01",
            "paper_type":"10",
            "student_type":studentType,
            "user_id":UserId,
            "weeklytest_Id":weeklyTestID
            ] as [String : Any]
        
        print("postData is",postData)
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("http://stagelearning.extramarks.com/school_lms/public/api/v1.0/weeklyv2", method: .post, parameters: postData, encoding: JSONEncoding.default )
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                            print("THE JSON RESULT 15",JSON)
                            let Status = JSON["response_code"] as? Int ?? 0
                            print("the status is",Status)
                            let status = JSON["status"] as? String ?? ""
                            print("the status is ",status)
                            if status   == "1" {
                                var arrScoreInfo = JSON["score_info"] as? NSDictionary ?? [:]
                                print("arrScoreInfo is",arrScoreInfo)
                                var correctQue = arrScoreInfo.value(forKey: "correct_que") as? String ?? ""
                                
                                
                                var incorrectQue = arrScoreInfo.value(forKey: "incorrect_que") as? String ?? ""
                                var skippedQue = arrScoreInfo.value(forKey: "skipped_que") as? String ?? ""
                                var total_questions = arrScoreInfo.value(forKey: "total_questions") as? String ?? ""
                                
                                var total_attempted_questions = arrScoreInfo.value(forKey: "total_attempted_questions") as? String ?? ""
                                
                                var time_taken = arrScoreInfo.value(forKey: "time_taken") as? String ?? ""
                                
                                var answer_speed = arrScoreInfo.value(forKey: "answer_speed") as? String ?? ""
                                
                                self.lblTotalQues.text = "/\(total_questions)"
                                self.lblTotalAttempted.text = total_attempted_questions
                                self.lblTimeTaken.text = "\(time_taken) Minutes"
                                self.lblAnswerSpeed.text = "\(answer_speed) min/ ques"
                                self.lblCorrectAns.text = correctQue
                                self.lblWrongAns.text = incorrectQue
                                self.lblSkippedQues.text = skippedQue
                                self.lblAccuracyText.text = "\(correctQue) correct out of \(total_attempted_questions) attempted answer"
                                
                                //Converting String value in double for graphs
                                let dTime_taken = Double(time_taken)
                                let dAnswer_speed = Double(answer_speed)
                                let dCorrectQue = Double(correctQue)
                                let dIncorrectQue = Double(incorrectQue)
                                let dSkippedQue = Double(skippedQue)
                                let dtotalAttemptedQues = Double(total_attempted_questions)
                                
                                var AaccuracyPercentge = dCorrectQue! / dtotalAttemptedQues! * 100
                                
                                var arcArray: [Arc] = [Arc]()
                                arcArray.append(Arc(c: #colorLiteral(red: 0.4033602476, green: 0.8931822777, blue: 0.6872150898, alpha: 1), v: dCorrectQue ?? 0.0))
                                arcArray.append(Arc(c: #colorLiteral(red: 0.9218646884, green: 0.4113363922, blue: 0.4478791952, alpha: 1), v: dIncorrectQue ?? 0.0 ))
                                arcArray.append(Arc(c: #colorLiteral(red: 0.5921034217, green: 0.5921911597, blue: 0.592084229, alpha: 1), v: dSkippedQue ?? 0.0))
                                self.viewGraphLoader.Start(array: arcArray, lWidth: 8.0)
                                
                                self.circleLoaderTimeTaken.Start(value: dTime_taken ?? 0.0, color: #colorLiteral(red: 0.9523274302, green: 0.5835757852, blue: 0.2794597745, alpha: 1))
                                self.circleLoaderAnswerSpeed.Start(value: dAnswer_speed ?? 0.0, color: #colorLiteral(red: 0.9523274302, green: 0.5835757852, blue: 0.2794597745, alpha: 1))
                                
                                var questionWiseAnalysis = JSON["question_wise_analysis"] as? NSArray ?? []
                                
                                var chapterWiseAnalysis = JSON["chapter_wise_analysis"] as? NSArray ?? []
                                
                                self.reviseChapter = JSON["revise_chapter"] as? NSArray ?? []
                                
                                var difficultyWiseAnalysis = JSON["difficulty_wise_analysis"] as? NSArray ?? []
                            }
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


//MARK:-*********_WebaApiCall_**********
//MARK:- API40()

extension testWiseAnlysis {
    func API40() {
        
        var Action = "test_wise_analysis"
        var paperType = "10"
        var studentType = "2"
        
        // auto_assign_id:userId :student_type :action:paperType :Salt:API_key
        
        let checkSumValues =  "\(autoID!):\(UserId!):\(studentType):\(Action):\(paperType):\(saltMainLMS):\(apikeyMainLMS)"
        var uparcaseChecksum = checkSumValues.uppercased()
        let myCheckString = MD5(uparcaseChecksum)
        
        let postData = [
            "action": Action,
            "checksum": myCheckString,
            "language_code": "01",//staic
            "paper_type": paperType,// static
            "student_type": studentType,
            "user_id": UserId,
            "weeklytest_Id": autoID//assign_auto_id
            ] as [String : Any]
        
        print("the chceksum String", checkSumValues)
        print("converted chceksum MD5 value ", myCheckString!)
        print("postData is",postData)
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("http://stagelearning.extramarks.com/school_lms/public/api/v1.0/weeklyv2", method: .post, parameters: postData, encoding: JSONEncoding.default )
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                            print("THE JSON RESULT 40",JSON)
                            let Status = JSON["response_code"] as? Int ?? 0
                            print("the status is",Status)
                            let status = JSON["status"] as? String ?? ""
                            print("the status is ",status)
                            if status   == "1" {
                                var arrScoreInfo = JSON["score_info"] as? NSDictionary ?? [:]
                                print("arrScoreInfo is",arrScoreInfo)
                                var correctQue = arrScoreInfo.value(forKey: "correct_que") as? String ?? ""
                                
                                var incorrectQue = arrScoreInfo.value(forKey: "incorrect_que") as? String ?? ""
                                var skippedQue = arrScoreInfo.value(forKey: "skipped_que") as? String ?? ""
                                var total_questions = arrScoreInfo.value(forKey: "total_questions") as? String ?? ""
                                
                                var total_attempted_questions = arrScoreInfo.value(forKey: "total_attempted_questions") as? String ?? ""
                                
                                var time_taken = arrScoreInfo.value(forKey: "time_taken") as? String ?? ""
                                
                                var answer_speed = arrScoreInfo.value(forKey: "answer_speed") as? String ?? ""
                                
                                self.lblTotalQues.text = "/\(total_questions)"
                                self.lblTotalAttempted.text = total_attempted_questions
                                self.lblTimeTaken.text = "\(time_taken) Minutes"
                                self.lblAnswerSpeed.text = "\(answer_speed) min/ ques"
                                self.lblCorrectAns.text = correctQue
                                self.lblWrongAns.text = incorrectQue
                                self.lblSkippedQues.text = skippedQue
                                self.lblAccuracyText.text = "\(correctQue) correct out of \(total_attempted_questions) attempted answer"
                                
                                //Converting String value in double for graphs
                                let dTime_taken = Double(time_taken)
                                let dAnswer_speed = Double(answer_speed)
                                let dCorrectQue = Double(correctQue)
                                let dIncorrectQue = Double(incorrectQue)
                                let dSkippedQue = Double(skippedQue)
                                let dtotalAttemptedQues = Double(total_attempted_questions)
                                
                                var AaccuracyPercentge = dCorrectQue! / dtotalAttemptedQues! * 100
                                
                                var arcArray: [Arc] = [Arc]()
                                arcArray.append(Arc(c: #colorLiteral(red: 0.4033602476, green: 0.8931822777, blue: 0.6872150898, alpha: 1), v: dCorrectQue ?? 0.0))
                                arcArray.append(Arc(c: #colorLiteral(red: 0.9218646884, green: 0.4113363922, blue: 0.4478791952, alpha: 1), v: dIncorrectQue ?? 0.0 ))
                                arcArray.append(Arc(c: #colorLiteral(red: 0.5921034217, green: 0.5921911597, blue: 0.592084229, alpha: 1), v: dSkippedQue ?? 0.0))
                                self.viewGraphLoader.Start(array: arcArray, lWidth: 8.0)
                                
                                self.circleLoaderTimeTaken.Start(value: dTime_taken ?? 0.0, color: #colorLiteral(red: 0.9523274302, green: 0.5835757852, blue: 0.2794597745, alpha: 1))
                                self.circleLoaderAnswerSpeed.Start(value: dAnswer_speed ?? 0.0, color: #colorLiteral(red: 0.9523274302, green: 0.5835757852, blue: 0.2794597745, alpha: 1))
                                
                                var questionWiseAnalysis = JSON["question_wise_analysis"] as? NSArray ?? []
                                
                                var chapterWiseAnalysis = JSON["chapter_wise_analysis"] as? NSArray ?? []
                                
                                self.reviseChapter = JSON["revise_chapter"] as? NSArray ?? []
                                
                                var difficultyWiseAnalysis = JSON["difficulty_wise_analysis"] as? NSArray ?? []
                                
                                print("difficultyWiseAnalysis is",difficultyWiseAnalysis)
                                
                                
                                
                                for (index, element) in difficultyWiseAnalysis.enumerated() {
                                    
                                    let dataDict = difficultyWiseAnalysis.object(at: index) as? NSDictionary ?? [:]
                                    
                                    let questionStatus = dataDict.value(forKey: "question_status") as? String ?? ""
                                    let timeTaken = dataDict.value(forKey: "time_taken") as? String ?? ""
                                    
                                    let timeTaken2 = Int(timeTaken)
                                    
                                    
                                    
                                    print("questionStatus is",questionStatus)
                                    print("timeTaken is",timeTaken2)
                                    
                                    
                                    if questionStatus == "right" {
                                        self.arrRight.add(timeTaken2)
                                    }
                                    else if questionStatus == "wrong" {
                                        self.arrWrong.add(timeTaken2)
                                        
                                    }
                                    else if questionStatus == "skipped" {
                                        
                                        self.arrSkipped.add(timeTaken2)
                                    }
                                    
                                    
                                    self.arrTimeTaken.add(timeTaken2)
                                    
                                }
                                
                                print("arrRight is",self.arrRight)
                                print("arrWrong is",self.arrWrong)
                                print("arrSkipped is",self.arrSkipped)
                                print("arrTimeTaken is",self.arrTimeTaken)
                                
                                
                                //                                "question_difficulty": "d",
                                //                                "question_status": "right",
                                //                                "time_taken": "5"
                                
                                
                                
                            }
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

extension testWiseAnlysis {
    func barChart() {
    }
}
