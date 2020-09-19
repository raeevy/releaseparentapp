//
//  goToSchoolReportVC.swift
//  Parent EdConnect
//
//  Created by Work on 27/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire
//API38


class goToSchoolReportVC: UIViewController {
    
    //MARK-*****_Aarray&varibales_*****
    //MARK:-
    var screenName2:String?
    var arrSubjectList1 = NSArray()
    var arrSubjectList2 = NSArray()
    var arrSubjectList3 = NSArray()
    var worksheetServiceId:Int?
    var homeworkServiceId:Int?
    var weeklyTestServiceId:Int?
    var videoCategory:String?
    
    var arrAssessmentReports = NSArray()
    var dicLiveClassReports = NSDictionary()
    var arrLiveClassAttendance = NSArray()

    
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    
    
    
    //MARK-*****_OUTLETS_*****
    //MARK:-
    
    @IBOutlet weak var lblLiveAttended: UILabel!
    @IBOutlet weak var lblLiveUnattended: UILabel!
    @IBOutlet weak var lblLiveStartIn: UILabel!
    @IBOutlet weak var lblLiveBy: UILabel!
    
    @IBOutlet weak var lblLiveclassSub: UILabel!
    @IBOutlet weak var lblWorkAssignedAttempt: UILabel!
    @IBOutlet weak var lblHomeAssignedAttempt: UILabel!
    @IBOutlet weak var lblWeeklyAssignedAttempt: UILabel!
    
    @IBOutlet weak var lblSCreenName: UILabel!
    @IBOutlet weak var viewLiveClassReoprt: UIView!
    @IBOutlet weak var viewWorksheet: UIView!
    @IBOutlet weak var viewHomework: UIView!
    @IBOutlet weak var viewWeeklyTestReoprt: UIView!
    
    //MARK:- ********_ViewDidLoad_*******
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientCrop()
        if UserId != nil && ClassId != nil && BoardId != nil {
            API38()
        }
        self.StatusBarSetup()
    }
    //MARK:- ********_viewWillAppear_*******
    //MARK:-
    override func viewWillAppear(_ animated: Bool) {
        lblSCreenName.text = screenName2
        UserDefaults.standard.set(videoCategory, forKey: "VIDEOCATEGORY")
    }
    //Status bar content
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- ********_buttonAction_*******
    //MARK:-
    
    @IBAction func btnWeeklyTestReport(_ sender: Any) {
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "worksheetHomeworkWeeklyOverviewVC") as! worksheetHomeworkWeeklyOverviewVC
        VC.subScreenCheck = 3
        VC.arrSubjectList = self.arrSubjectList3
        VC.ServiceId = weeklyTestServiceId
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnLiveClassReport(_ sender: Any) {
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "liveClassReportVC") as! liveClassReportVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "VIDEOCATEGORY")
        self.navigationController?.backToViewController(viewController: homeScreenVC.self)
    }
    @IBAction func btnToggle(_ sender: Any) {
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "goToSchoolReportGraphVC") as! goToSchoolReportGraphVC
        VC.screenName =  screenName2
        VC.arrAssessmentReports2 = arrAssessmentReports
        VC.dicLiveClassReports2 = dicLiveClassReports
        VC.arrLiveClassAttendance2 = arrLiveClassAttendance
        self.navigationController?.pushViewController(VC, animated: false)
    }
    @IBAction func btnWorksheet(_ sender: Any) {
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "worksheetHomeworkWeeklyOverviewVC") as! worksheetHomeworkWeeklyOverviewVC
        VC.subScreenCheck = 1
        VC.arrSubjectList = self.arrSubjectList1
        VC.ServiceId = worksheetServiceId
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnHomework(_ sender: Any) {
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "worksheetHomeworkWeeklyOverviewVC") as! worksheetHomeworkWeeklyOverviewVC
        VC.subScreenCheck = 2
        VC.arrSubjectList = self.arrSubjectList2
        VC.ServiceId = homeworkServiceId
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

//MARK:- ********_UI_Implementation_*******
//MARK:-
extension goToSchoolReportVC {
    func gradientCrop() {
        viewLiveClassReoprt.gradientBlueWithCornerRadius()
        viewWorksheet.gradientBlueWithCornerRadius()
        viewHomework.gradientBlueWithCornerRadius()
        viewWeeklyTestReoprt.gradientBlueWithCornerRadius()
    }
}

//MARK:- *****_WEB_API_CALL_******
//mark:-  ****_API: 38
extension goToSchoolReportVC {
    func API38() {
        
        let StudentType = "2"
        let Action = "weekly_school_report_dashboard"
        
        var schoolID = UserDefaults.standard.value(forKey: "SCHOOLID")
        var section = UserDefaults.standard.value(forKey: "SECTION")
        var sectionID = UserDefaults.standard.value(forKey: "SECTIONID")
        let checkSumValues =  "\(UserId!):\(StudentType):\(BoardId!):\(ClassId!):\(Action):\(saltMainLMS):\(apikeyMainLMS)"
        var uparcaseChecksum = checkSumValues.uppercased()
        let myCheckString = MD5(uparcaseChecksum)
        
        let postData = [
            "action": Action,
            "board_id": BoardId,
            "checksum": myCheckString,
            "class_id": ClassId!,
            "school_id": schoolID,
            "section_id": sectionID,
            "section_name": section,
            "student_type": StudentType,
            "timezone": "Asia/Kolkata",
            "user_id": UserId
            ] as [String : Any]
        print("the chceksum String", checkSumValues)
        print("converted chceksum MD5 value ", myCheckString!)
        print("postData is",postData)
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("http://stagelearning.extramarks.com/school_lms/public/api/v1.0/weeklyv2", method: .post, parameters: postData, encoding: JSONEncoding.default )
              //  "http://stagelearning.extramarks.com/school_lms/public/"
                
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                            print("THE JSON RESULT",JSON)
                            let Status = JSON["response_code"] as? Int ?? 0
                            print("the status is",Status)
                            let status = JSON["status"] as? Int ?? 0
                            print("the status is ",status)
                            
                            if status == 1 {
                                
                                self.arrAssessmentReports = JSON["assessment_reports"] as? NSArray ?? []
                                self.dicLiveClassReports = JSON["live_class_reports"] as? NSDictionary ?? [:]
                                self.arrLiveClassAttendance = JSON["live_class_attendance"] as? NSArray ?? []
                                
                                let dictWorkSheet = self.arrAssessmentReports.object(at: 1) as? NSDictionary ?? [:]
                                let dictHomework = self.arrAssessmentReports.object(at: 2) as? NSDictionary ?? [:]
                                let dictWeeklyTest = self.arrAssessmentReports.object(at: 0) as? NSDictionary ?? [:]
                                
                                self.arrSubjectList1 = dictWorkSheet.value(forKey: "subject_list") as? NSArray ?? []
                                self.worksheetServiceId = dictWorkSheet.value(forKey: "service_id") as? Int ?? 0
                                print("WorkSheet serviceId Is",self.worksheetServiceId)
                                
                                self.arrSubjectList2 = dictHomework.value(forKey: "subject_list") as? NSArray ?? []
                                self.homeworkServiceId = dictHomework.value(forKey: "service_id") as? Int ?? 0
                                print("Homework serviceId Is",self.worksheetServiceId)
                                
                                
                                self.arrSubjectList3 = dictWeeklyTest.value(forKey: "subject_list") as? NSArray ?? []
                                self.weeklyTestServiceId = dictWeeklyTest.value(forKey: "service_id") as? Int ?? 0
                                print("WeeklyTest serviceId Is",self.weeklyTestServiceId)
                                
                                
                                
                                print("self.arrSubjectList1 is",self.arrSubjectList1)
                                print("self.arrSubjectList2 is",self.arrSubjectList2)
                                print("self.arrSubjectList3 is",self.arrSubjectList3)
                                
                                
                                let weekAssigned = dictWeeklyTest.value(forKey: "assigned") as? Int ?? 0
                                let weekAttempted = dictWeeklyTest.value(forKey: "attempted") as? Int ?? 0
                                
                                let workAssigned = dictWorkSheet.value(forKey: "assigned") as? Int ?? 0
                                let workAttempted = dictWorkSheet.value(forKey: "attempted") as? Int ?? 0
                                
                                let homeAssigned = dictHomework.value(forKey: "assigned") as? Int ?? 0
                                let homeAttempted = dictHomework.value(forKey: "attempted") as? Int ?? 0
                                
                                let liveClassSub = self.dicLiveClassReports.value(forKey: "upcoming_live_class_subject_name") as? String ?? ""
                                
                                 let liveClassStartIn = self.dicLiveClassReports.value(forKey: "upcoming_live_class_starts_in") as? String ?? ""
                                
                                let liveClassBy = self.dicLiveClassReports.value(forKey: "upcoming_live_class_faculty_name") as? String ?? ""
                                let totalLiveSesion = self.dicLiveClassReports.value(forKey: "total_live_sessions") as? Int ?? 0
                                
                                let attendLiveSesion = self.dicLiveClassReports.value(forKey: "attended_live_sessions") as? Int ?? 0
                                
                                let unattendLiveSession = totalLiveSesion - attendLiveSesion
                                 
                                self.lblLiveclassSub.text  = "Subject: \(liveClassSub)"
                                self.lblLiveStartIn.text = "Starts In: \(liveClassStartIn)"
                                self.lblLiveBy.text = "By: \(liveClassBy)"
                                self.lblLiveAttended.text = "\(attendLiveSesion) Attended"
                                self.lblLiveUnattended .text = "\(unattendLiveSession) Unattended"
                          
                                self.lblWeeklyAssignedAttempt.text = "\(weekAssigned) Assigned | \(weekAttempted) Attempted"
                                self.lblWorkAssignedAttempt.text = "\(workAssigned) Assigned | \(workAttempted) Attempted"
                                self.lblHomeAssignedAttempt.text = "\(homeAssigned) Assigned | \(homeAttempted) Attempted"

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
