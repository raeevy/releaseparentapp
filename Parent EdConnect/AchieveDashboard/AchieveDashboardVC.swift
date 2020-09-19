//
//  AchieveDashboardVC.swift
//  Parent EdConnect
//
//  Created by Work on 07/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class AchieveDashboardVC: UIViewController {
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    var name = UserDefaults.standard.value(forKey: "NAME")
    var email = UserDefaults.standard.value(forKey: "EMAIL")
    var mobileNo = UserDefaults.standard.value(forKey: "MOBILE")
    
    @IBOutlet weak var lblGraphValue: UILabel!
    @IBOutlet weak var lblMentorName: UILabel!
    @IBOutlet weak var lblMentorMsg: UILabel!
    @IBOutlet weak var lblMileStones: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgFooter: UIImageView!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var btnScheduleCall: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet weak var viewBulletComplMilstn: UIView!
    @IBOutlet weak var viewBulletIncmpltMilstn: UIView!
    @IBOutlet weak var viewGrapLoader: CircularArc!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBackground.isHidden = true
        viewPopup.isHidden = true
        gradientCrop()
        StatusBarSetup2()
        
        if UserId != nil && ClassId != nil && BoardId != nil {
            achieveDashboardAPI()
        }
        else {
            alert(message: "something went wrong")
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnHomework(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "worksheetVC") as! worksheetVC
        VC.assignmentType = "18"
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnMilesstones(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "milestonesVC") as! milestonesVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnWorkSheet(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "worksheetVC") as! worksheetVC
        VC.assignmentType = "17"
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnAssignedTask(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "taskAchieveVC") as! taskAchieveVC
        VC.taskType = "01"
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnPendingTask(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "taskAchieveVC") as! taskAchieveVC
        VC.taskType = "02"
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func tapShceduleCall(_ sender: Any) {
        viewBackground.isHidden = false
        viewPopup.isHidden = false
        scrollView.isScrollEnabled = false
    }
    
    @IBAction func tapDissmissPop(_ sender: Any) {
        viewBackground.isHidden = true
        viewPopup.isHidden = true
        scrollView.isScrollEnabled = true
    }
    
    @IBAction func btnOk(_ sender: Any) {
        reqCallBackApi()
    }
}

extension AchieveDashboardVC {
    func gradientCrop() {
        btnScheduleCall.gradientYellow2()
        btnScheduleCall.layer.cornerRadius = 21.0
        btnScheduleCall.layer.masksToBounds = true;
        viewLine.gradientViolet()
        imgFooter.clipsToBounds = true
        imgFooter.layer.cornerRadius = 10.0
        
        viewBulletComplMilstn.layer.cornerRadius = viewBulletComplMilstn.frame.size.width / 2
        viewBulletComplMilstn.clipsToBounds = true
        
        viewBulletIncmpltMilstn.layer.cornerRadius = viewBulletIncmpltMilstn.frame.size.width / 2
        viewBulletIncmpltMilstn.clipsToBounds = true
    }
}


//mark:-*************_web_Api_*******
//mark:-

extension AchieveDashboardVC {
    func  achieveDashboardAPI() {
        
        var isNewApp = 1
        var action = "get_mentor_dashboard"
        
        var checkSumValues =  "\(action):\(BoardId!):\(ClassId!):\(UserId!):\(apiKeyj):\(Saltj)"
        
        //action:boardId:classId:userId:ApiKey:Salt
        
        let myCheckString = MD5(checkSumValues)
        
        print("the chceksum String", checkSumValues)
        print("converted chceksum value ", myCheckString!)
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        // 180:36:1:67710419
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("\(baseUrl)api/v1.0/getdashboarddata?action=\(action)&board_id=\(BoardId!)&class_id=\(ClassId!)&user_id=\(UserId!)&apikey=\(apiKeyj)&checksum=\(myCheckString!)", method: .get, encoding: JSONEncoding.default, headers: headers)
                
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            
                            self.hideActivityIndicator()
                            print("THE JSON RESULT",JSON)
                            
                            let message = JSON["message"] as? String ?? ""
                            print("the message is",message)
                            
                            if message == "success" {                                      self.hideActivityIndicator()
                                
                                let mentorMessage = JSON["mentor_message"] as? String ?? ""
                                let mentorName = JSON["mentor_name"] as? String ?? ""
                                let mentorProfilePic = JSON["mentor_profile_pic"] as? String ?? ""
                                
                                let dictUpcomingVideoCallSchedule = JSON["upcoming_video_call_schedule"] as? NSDictionary ?? [:]
                                
                                let dicMilestoneDetail = JSON["milestone_detail"] as? NSDictionary ?? [:]
                                
                                let completedMilestones = dicMilestoneDetail.value(forKey: "completed_milestones") as? Int ?? 1
                                
                                let incompletedMilestones = dicMilestoneDetail.value(forKey: "incompleted_milestones") as? Int ?? 1
                                
                                var arcArray: [Arc] = [Arc]()
                                arcArray.append(Arc(c: #colorLiteral(red: 0.8046142459, green: 0.3054817319, blue: 0.3704778254, alpha: 1), v: Double(completedMilestones)))
                                arcArray.append(Arc(c: #colorLiteral(red: 0.3847677112, green: 0.8493306041, blue: 0.6094711423, alpha: 1), v: Double(incompletedMilestones)))
                                
                                self.lblGraphValue.text = " \(completedMilestones)/\(incompletedMilestones)"
                                
                                self.viewGrapLoader.Start(array: arcArray, lWidth: 8.0)
                                
                                
                                let milestones = completedMilestones + incompletedMilestones
                                
                                self.lblMileStones.text = "\(milestones) Milestones"
                                self.lblMentorName.text = mentorName
                                self.lblMentorMsg.text = mentorMessage
                                self.imgProfile.sd_setImage(with: URL(string: mentorProfilePic))
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




extension AchieveDashboardVC {
    
    func reqCallBackApi() {
        var action = "save_request"
        var checkSum =  "\(action):\(apiKeyj):\(Saltj)"
        let myChecksum = MD5(checkSum)
        
        let postData = [
            "action":"save_request",
            "address":"",
            "apikey":apiKeyj,
            "app_name":"Parent EdConnect",
            "board_id":BoardId,
            "checksum":myChecksum,
            "city":"noida",
            "city_area":"",
            "city_area_id":"",
            "city_id":"",
            "class_id":ClassId,
            "demo_date":"",
            "email":email,
            "mobile_no":mobileNo,
            "name":name,
            "request_type":"Request a call back",
            "source":"em_achieve_snaap_boarding",
            "user_id":UserId
            ] as [String : Any]
        
        print("the chceksum String", checkSum)
        print("converted chceksum value ", myChecksum!)
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("\(baseUrl)api/v1.0/chatsectiondata", method: .post, parameters: postData, encoding: JSONEncoding.default )
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                            print("THE JSON RESULT",JSON)
                            let Status = JSON["response_code"] as? Int ?? 0
                            print("the status is",Status)
                            let message = JSON["message"] as? String ?? ""
                            print("the message is ",message)
                            if message == "success" {                                      self.hideActivityIndicator()
                                self.viewBackground.isHidden = true
                                self.viewPopup.isHidden = true
                                self.scrollView.isScrollEnabled = true
                            }
                            else {
                                self.alert(message: message)
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
