//
//  WeeklyTestPerformanceVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/20/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire

class WeeklyTestPerformanceVC: UIViewController {
    
    @IBOutlet weak var viewOverView: UIView!
    @IBOutlet weak var viewCircularProgresh: CircularArc!
    @IBOutlet weak var lblAvragePerformance: UILabel!
    @IBOutlet weak var lblShowPercentage: UILabel!
    @IBOutlet weak var btnTotalTestTakenClick: UIButton!
    @IBOutlet weak var lblTotalTestTakenShow: UILabel!
    @IBOutlet weak var viewYouAreAnAvrageOverView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var attempedTVCustomHeights: NSLayoutConstraint!
    @IBOutlet weak var viewSubjectWisePerformanceContents: UIView!
    @IBOutlet weak var testAttendTV: UITableView! {
        didSet {
            self.testAttendTV.delegate = self
            self.testAttendTV.dataSource = self
        }
    }
    @IBOutlet weak var subjectWisePerformanceCVCell: UICollectionView! {
        didSet {
            self.subjectWisePerformanceCVCell.delegate = self
            self.subjectWisePerformanceCVCell.dataSource = self
        }
    }
    
    @IBOutlet weak var listTableView: UITableView!{
        didSet {
            self.listTableView.delegate = self
            self.listTableView.dataSource = self
        }
    }
    
//    var boardId:String?
//    var classId:String?
//    var class_id:String?
//    var language_code:String?
//    var paper_type:String?
//
    
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    var studentId = UserDefaults.standard.value(forKey: "CHILDID")
    var language_code  = "7"
       
    ///Array
    var subject_list:String?
    var subjectsPerformanceInfo = NSArray()
    var keyFocusArea = NSArray()
    var recentlyTakenTests = NSArray()
    
    var subjectID = 176
    
    
    
    ///MARK:- View LifeCycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetupUI()
        self.StatusBarSetup()
        self.listTableView.rowHeight = UITableView.automaticDimension
         self.testAttendTV.rowHeight = UITableView.automaticDimension
        
//            self.attempedTVCustomHeights.constant = testAttendTV.contentSize.height
//                   let arrCount:Int = self.subjectsPerformanceInfo.count ?? 1
//                    self.attempedTVCustomHeights.constant = CGFloat(80 * arrCount)

        listTableView.register(UINib.init(nibName: "RecentlyTakenTestWeeklyTestTVC", bundle: nil), forCellReuseIdentifier: "RecentlyTakenTestWeeklyTestTVC")
          listTableView.register(UINib.init(nibName: "KeyFoarceAreALabelTVC", bundle: nil), forCellReuseIdentifier: "KeyFoarceAreALabelTVC")
        listTableView.register(UINib.init(nibName: "KeyFocusAreaXIBTVC", bundle: nil), forCellReuseIdentifier: "KeyFocusAreaXIBTVC")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.weeklyMainApi()
        self.testAttempApi()
        
    }
        
    ///Mark:-Status Bar Change
      override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    ///Mark:- UI Customization .
       func SetupUI()  {
        //   self.viewYouAreAnAvrageOverView.gradientYellow()
        self.viewYouAreAnAvrageOverView.layer.cornerRadius = 10
        
        self.viewOverView.layer.borderWidth = 1
        self.viewOverView.layer.borderColor = UIColor.lightGray.cgColor
        self.viewOverView.layer.cornerRadius = 10
        self.viewSubjectWisePerformanceContents.layer.borderWidth = 1
        self.viewSubjectWisePerformanceContents.layer.borderColor = UIColor.lightGray.cgColor
        self.viewSubjectWisePerformanceContents.layer.cornerRadius = 10
          
       }
    
    ///MARK:- Button Actions.
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

///MARK:- TableView Delegate and Data Sorce Methords.
extension WeeklyTestPerformanceVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == testAttendTV{
            return 1
        } else  {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == testAttendTV {
            print("Arry Count Is :-", self.subjectsPerformanceInfo.count)
            return self.subjectsPerformanceInfo.count
        } else {
            
            switch section {
            case 0:
                return 1
            case 1:
                return 1
            case 2:
                return self.keyFocusArea.count
            default:
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if tableView == testAttendTV {
            return 33
        } else {
            
            switch indexPath.section {
            case 0:
                return 200
                    //UITableView.automaticDimension
            case 1:
                return 60
            case 2:
                return 180
            default:
                return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == testAttendTV {
            
            let cell = testAttendTV.dequeueReusableCell(withIdentifier: "TestAttendTableViewCell") as! TestAttendTableViewCell
            
            let subjectsPerformanceInfoDict = self.subjectsPerformanceInfo[indexPath.row] as? NSDictionary ?? [:]
            
            cell.lblNameSubject.text = subjectsPerformanceInfoDict.value(forKey: "subject_name") as? String ?? ""
            let colorCode = subjectsPerformanceInfoDict.value(forKey: "color_code") as? String ?? ""
            
            let progressValue = subjectsPerformanceInfoDict.value(forKey: "subject_percentage") as? Double ?? 0.0
            let max = 100.0
            let lenghts = progressValue / max
            cell.progressBarSubject.setProgress(Float(lenghts), animated: false)
            cell.lblAttemptValue.text = "\(progressValue)"
            
            ///  ******Fow Download Image.*********
            let subjectIcon = subjectsPerformanceInfoDict.value(forKey: "subject_icon") as? String ?? ""
            let subjectColorCode = subjectsPerformanceInfoDict.value(forKey: "color_code") as? String ?? ""
            cell.imgSubject.sd_setImage(with: URL(string: subjectIcon))
            cell.imgSubject.backgroundColor = UIColor.init(hexString: subjectColorCode)
            cell.imgSubject.layer.cornerRadius = cell.imgSubject.frame.size.width / 2
            cell.imgSubject.clipsToBounds = true
            
            
            print("subjectIcon",subjectIcon)
            
            return cell
            
        } else  {
            
            switch indexPath.section {
            case 0:
                guard let cell:RecentlyTakenTestWeeklyTestTVC = tableView.dequeueReusableCell(withIdentifier: "RecentlyTakenTestWeeklyTestTVC") as? RecentlyTakenTestWeeklyTestTVC else { return UITableViewCell() }
                
                cell.parentWeeklyVC = self
                cell.arrResentlyTakenTestCell = self.recentlyTakenTests
//                //For Custom TV Heights.
                cell.customHeightsContrantsTV.constant = cell.xibTableResentlyTT.contentSize.height
                let arrCount:Int = self.recentlyTakenTests.count ?? 1
                cell.customHeightsContrantsTV.constant = CGFloat(103 * arrCount)

                cell.xibTableResentlyTT.reloadData()
                
                    return cell
            case 1:
                 guard let cell:KeyFoarceAreALabelTVC = tableView.dequeueReusableCell(withIdentifier: "KeyFoarceAreALabelTVC") as? KeyFoarceAreALabelTVC else { return UITableViewCell() }
                 
                       return cell
            case 2:
                 guard let cell:KeyFocusAreaXIBTVC = tableView.dequeueReusableCell(withIdentifier: "KeyFocusAreaXIBTVC") as? KeyFocusAreaXIBTVC else { return UITableViewCell() }
                 
                let dictKeyFA = keyFocusArea[indexPath.row] as? NSDictionary ?? [:]
                 print("DictKey is ", dictKeyFA)
                 cell.lblKeyFocusName.text = dictKeyFA.value(forKey: "subject_name") as? String ?? ""
                 let targetValue = dictKeyFA.value(forKey: "target_score") as? Int ?? 0
                 cell.lblTargetShow.text = "\(targetValue)"
                 let progress = dictKeyFA.value(forKey: "performance_percentage") as? Double ?? 0.0
                 let max = 100.0
                 let lenght = progress / max
                 cell.lblShowScore.text = "\(progress)"
                 cell.progressBar.setProgress(Float(lenght), animated: false)
                 print("progress is ", progress)
               
                    return cell
            default:
                
                let cell = UITableViewCell()
                return cell
            }
        }
        return UITableViewCell()
    }
    
}

///MARK:- Collection View Delegate and Data Sorce Methords.
extension WeeklyTestPerformanceVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = subjectWisePerformanceCVCell.dequeueReusableCell(withReuseIdentifier: "SubjectWisePerformanceCollectionViewCell", for: indexPath) as! SubjectWisePerformanceCollectionViewCell
        
        cell.viewCircular.layer.borderWidth = 4
        cell.viewCircular.layer.borderColor = UIColor.lightGray.cgColor
        cell.viewCircular.layer.cornerRadius = 40
       // cell.viewCircular.shadow(UIView: cell.viewCircular)
        
        return cell
    }
    
//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
////               let storyBord = UIStoryboard(name: "Home", bundle: nil)
////                 let VC = storyBord.instantiateViewController(withIdentifier: "SubjectWisePerformanceVC") as! SubjectWisePerformanceVC
////                 self.navigationController?.pushViewController(VC, animated: true)
//        }
    
   
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let noOfCellsInRow = 3
       let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
       let totalSpace = flowLayout.sectionInset.left
           + flowLayout.sectionInset.right
           + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
       let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

       return CGSize(width: size, height: 134)
   }
    
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//            let collectionViewWidth = collectionView.bounds.width
//            return CGSize(width: collectionViewWidth/3, height: collectionViewWidth/3)
//        }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let yourWidth = collectionView.bounds.width/3.0
//        let yourHeight = yourWidth
//
//        return CGSize(width: yourWidth, height: yourHeight)
//    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 1
        }

    
}

///Main Weekly Api. 13
extension WeeklyTestPerformanceVC {
    func weeklyMainApi() {
        var action = "overall_performance_analysis"
        var studentType = 2
        var apiKey = "8FF8508F917BCC12FFDCD"
        var salt = "EF6C40ECBA"
        var unknown = "10"
        //10
        
        var checkSum =  "\(UserId!):\(studentType):\(BoardId!):\(ClassId!):\(action):\(unknown):\(salt):\(apiKey)"
        var uparcaseChecksum = checkSum.uppercased()
        let myChecksum = MD5(uparcaseChecksum)

//        let postData = [
//            "action":action,
//            "board_id":BoardId!,
//            "checksum":myChecksum!,
//            "class_id":ClassId!,
//            "language_code":"01",
//            "paper_type":"10",
//            "student_type":"2",
//            "user_id":UserId!
//            ] as [String : Any]
        
        let postData = [
            "action": action,
            "board_id":BoardId!,
            "checksum":myChecksum!,
            "class_id":ClassId!,
            "language_code":"01",
            "paper_type":"10",
            "student_type":"2",
            "user_id":UserId!] as? [String:Any]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]

        print("the chceksum String 13", checkSum)
        print("uparcaseChecksum is 13",uparcaseChecksum)
        print("converted chceksum MD5 value 13", myChecksum!)
        print("postData is 13 ",postData!)

        if Reachability.isConnectedToNetwork() {
           showActivityIndicator()
            AF.request("http://stagelearning.extramarks.com/school_lms/public/api/v1.0/weeklyv2", method: .post, parameters: postData, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                            print("THE JSON RESULT 13",JSON)
                            
                            let dictOverallPerformance = JSON["overall_performance"] as? NSDictionary ?? [:]
                            
                            let weeklyTestAnalysis = dictOverallPerformance.value(forKey: "weekly_test_analysis") as? NSDictionary ?? [:]
                            
                         //   self.subjectID = weeklyTestAnalysis.va
                            
                            self.keyFocusArea = weeklyTestAnalysis.value(forKey: "key_focus_area") as? NSArray ?? []
                            print("Key data is ", self.keyFocusArea)
                            self.recentlyTakenTests = weeklyTestAnalysis.value(forKey: "recently_taken_tests") as? NSArray ?? []
                            print("recentlyTakenTests data is ", self.recentlyTakenTests)
                            
                            
                            ///API 14 Hitting.
                            self.subjectWisePerformanceApi()
                            
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


//API For Top table > Test Attemp And OverView.
extension WeeklyTestPerformanceVC {
    ///API 12
    func testAttempApi() {
        var action = "test_subject_list"
        var studentType = "2"
         var apiKey = "8FF8508F917BCC12FFDCD"
        var salt = "EF6C40ECBA"
        var userID = UserDefaults.standard.value(forKey: "USERID")
        var checkSum =  "\(userID!):\(studentType):\(BoardId!):\(ClassId!):\(action):\(paper_type):\(salt):\(apiKey)"
        var uparcaseChecksum = checkSum.uppercased()
        let myChecksum = MD5(uparcaseChecksum)
        
        let postData = [
        "student_id":userID!,
        "student_type":"2",
        "board_id":BoardId!,
        "class_id":ClassId!,
        "action":"test_subject_list",
        "paper_type":"10",
        "subject_list":"177,176,171,182,557202,206,203,310768,214",
        "language_code":"01",
        "checksum":myChecksum!
            ] as [String : Any]

        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]

        print("the chceksum String 12", checkSum)
        print("uparcaseChecksum is 12",uparcaseChecksum)
        print("converted chceksum MD5 value 12", myChecksum!)
        print("postData is 12",postData)
        print("userID is ", userID)

        if Reachability.isConnectedToNetwork() {
           showActivityIndicator()
            AF.request("http://stagelearning.extramarks.com/school_lms/public/api/v1.0/weeklyv2", method: .post, parameters: postData, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                            print("THE JSON RESULT 12",JSON)
                            
                             let dictPerformanceInfo = JSON["performance_info"] as? NSDictionary ?? [:]
                            
                            self.subjectsPerformanceInfo = dictPerformanceInfo.value(forKey: "subjects_performance_info") as? NSArray ?? []
                            
                            print("subjectsPerformanceInfo is:-",  self.subjectsPerformanceInfo)
                            let totalTestAttempted = dictPerformanceInfo.value(forKey: "total_test_attempted") as? String ?? ""
                            self.lblTotalTestTakenShow.text = totalTestAttempted
                            let total_average_percentage = dictPerformanceInfo.value(forKey: "total_average_percentage") as? Int ?? 0
                            self.lblShowPercentage.text = "\(total_average_percentage)"
                            let remainSpace = 100 - total_average_percentage
                            var arcArray: [Arc] = [Arc]()
                            arcArray.append(Arc(c: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), v: Double(total_average_percentage ?? 0)))
                            arcArray.append(Arc(c: #colorLiteral(red: 0.5921034217, green: 0.5921911597, blue: 0.592084229, alpha: 1), v: Double(remainSpace ?? 0)))
                            self.viewCircularProgresh.Start(array: arcArray, lWidth: 8.0)
                            let percentage_title = dictPerformanceInfo.value(forKey: "percentage_title") as? String ?? ""
                            self.lblAvragePerformance.text = percentage_title
                            self.testAttendTV.reloadData()

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


extension WeeklyTestPerformanceVC {
    //API 14
    func subjectWisePerformanceApi() {
        var action = "subject_wise_performance_analysis"
        var studentType = "2"
        var apiKey = "8FF8508F917BCC12FFDCD"
        var salt = "EF6C40ECBA"
        var unknown = "10"
        
        var checkSum =  "\(UserId!):\(studentType):\(BoardId!):\(ClassId!):\(action):\(unknown):\(subjectID):\(salt):\(apiKey)"
        var uparcaseChecksum = checkSum.uppercased()
        let myChecksum = MD5(uparcaseChecksum)

        let postData = [
        "action":"subject_wise_performance_analysis",
        "board_id":BoardId!,
        "checksum":myChecksum!,
        "class_id":ClassId!,
        "language_code":"01",
        "paper_type":"10",
        "student_type":"2",
        "subject_id": "176",
        "user_id":UserId!
            ] as [String : Any]

        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]

        print("the chceksum String 14", checkSum)
        print("uparcaseChecksum is 14",uparcaseChecksum)
        print("converted chceksum MD5 value 14", myChecksum!)
        print("postData is 14",postData)

        if Reachability.isConnectedToNetwork() {
           showActivityIndicator()
            AF.request("http://stagelearning.extramarks.com/school_lms/public/api/v1.0/weeklyv2", method: .post, parameters: postData, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                            print("THE JSON RESULT 14",JSON)
                            
//                             let dictPerformanceInfo = JSON["performance_info"] as? NSDictionary ?? [:]
//
//                                self.subjectsPerformanceInfo = dictPerformanceInfo.value(forKey: "subjects_performance_info") as? NSArray ?? []
//
//                            let totalTestAttempted = dictPerformanceInfo.value(forKey: "total_test_attempted") as? String ?? ""
//                            self.lblTotalTestTakenShow.text = totalTestAttempted
//
//                            let total_average_percentage = dictPerformanceInfo.value(forKey: "total_average_percentage") as? Int ?? 0
//
//                            self.lblShowPercentage.text = "\(total_average_percentage)"
//
//                            let remainSpace = 100 - total_average_percentage
//
//                            var arcArray: [Arc] = [Arc]()
//                            arcArray.append(Arc(c: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), v: Double(total_average_percentage ?? 0)))
//                            arcArray.append(Arc(c: #colorLiteral(red: 0.5921034217, green: 0.5921911597, blue: 0.592084229, alpha: 1), v: Double(remainSpace ?? 0)))
//                            self.viewCircularProgresh.Start(array: arcArray)
//
//
//                            let percentage_title = dictPerformanceInfo.value(forKey: "percentage_title") as? String ?? ""
//
//                            self.lblAvragePerformance.text = percentage_title
                            self.subjectWisePerformanceCVCell.reloadData()

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
