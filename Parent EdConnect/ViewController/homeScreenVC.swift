//homeScreenVC.swift
//Parent EdConnect
//Created by Work on 10/06/20.
//Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.

import UIKit
import Alamofire
import SDWebImage

var curveEaseIn = UIView.AnimationOptions()
class homeScreenVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    //Mark:- ********_Array_&_Vriables_********
    //Mark:-
    var mySlideMenu = false
    var arrImg = [#imageLiteral(resourceName: "name"), #imageLiteral(resourceName: "userName"),#imageLiteral(resourceName: "icon2"), #imageLiteral(resourceName: "password")]
    var dicOverallPerformance = NSArray()
    let shapeLayer = CAShapeLayer()
   
    var arrData = ["Add Child", "Request a Callback", "Rate Us", "Logout"]
    var userName = UserDefaults.standard.value(forKey: "NAME")
    var thechildName = UserDefaults.standard.value(forKey: "CHILDNAME")
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
    var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
    var classIs = UserDefaults.standard.value(forKey: "CLASS")
    var lastActive = UserDefaults.standard.value(forKey: "LASTACTIVE")
    let arrayUserDef =  UserDefaults.standard.array(forKey: "ARRCHILD")
    var profilPic = UserDefaults.standard.value(forKey: "PROFILEPIC")
    
    var selectedSchoolId:String?
    var selectedSection:String?
    var selectedSectionId:String?
    
    var selectedUserID:String?
    var selectedlastActiveOn:String?
    var selectedClass:String?
    var selectedChildName:String?
    var selectedBoardId:String?
    var selectedClassID:String?
    var selectedProfilePic:String?
    var  dicPerformanceStats = NSDictionary()
    var schoolDetails = NSDictionary()
    
    //Mark:- ********_OUTLETS_********
    //Mark:-
    
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var childTable: UITableView!
    @IBOutlet weak var viewPerformaceStatistics: CustomView!
    @IBOutlet weak var viewSubjWisePerformace: CustomView!
    @IBOutlet weak var viewBloom: CustomView!
    @IBOutlet weak var viewTimeInapp: CustomView!
    @IBOutlet weak var viewGraphLoader: CircularArc!  
    @IBOutlet weak var lblTotaltests: UILabel!
    @IBOutlet weak var lblCorrectAnswer: UILabel!
    @IBOutlet weak var lblWrongAnswer: UILabel!
    @IBOutlet weak var lblSkippedQuestions: UILabel!
    @IBOutlet weak var lblOverAllProgress: UILabel!
    @IBOutlet weak var lblUserNameis: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var leadingConstrain: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblStartInSchoolAtHome: UILabel!
    @IBOutlet weak var viewTodayTime: UIView!
    @IBOutlet weak var viewSchoolAtHome: UIView!
    @IBOutlet weak var viewCandATest: UIView!
    @IBOutlet weak var viewPJReprt: UIView!
    @IBOutlet weak var viewArechiveDashboard: UIView!
    @IBOutlet weak var viewWeeklyTestReport: UIView!
    @IBOutlet weak var viewPrentTeacher: UIView!
    @IBOutlet weak var viewSelectChild: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var bullet1: UILabel!
    @IBOutlet weak var bullet2: UILabel!
    @IBOutlet weak var bullet3: UILabel!
    @IBOutlet weak var sideBarView: UIView!
    @IBOutlet weak var sideBarTable: UITableView! ////
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var lblParentNametop: UILabel!
    @IBOutlet weak var lblChlidNameTop: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var lblLastActive: UILabel!
    @IBOutlet weak var viewChildConnect: UIView!
    @IBOutlet weak var viewGoToSchool: UIView!
    @IBOutlet weak var lblSchoolName: UILabel!
    @IBOutlet weak var lblSchoolAddress: UILabel!
    @IBOutlet weak var lblLectureGts: UILabel!
    @IBOutlet weak var lblChlidNameForTime: UILabel!
    
    @IBOutlet weak var lblBloom1: UILabel!
    @IBOutlet weak var lblBloom2: UILabel!
    @IBOutlet weak var lblBloom3: UILabel!
    @IBOutlet weak var lblBloom4: UILabel!
    @IBOutlet weak var lblBloom5: UILabel!
    @IBOutlet weak var lblBloom6: UILabel!
    
    @IBOutlet weak var lblBloomTotal1: UILabel!
    @IBOutlet weak var lblBloomTotal2: UILabel!
    @IBOutlet weak var lblBloomTotal3: UILabel!
    @IBOutlet weak var lblBloomTotal4: UILabel!
    @IBOutlet weak var lblBloomTotal5: UILabel!
    @IBOutlet weak var lblBloomTotal6: UILabel!
    
    //Mark:- ********__viewCycle_viewDidload_********
    //Mark:-
    override func viewDidLoad() {
        print("arrayUserDef is",arrayUserDef)
        super.viewDidLoad()
        homeBarSetup()
        if UserId != nil && ClassId != nil && BoardId != nil {
        ApiDashboardData()
        }
        gradiantCrop()
        viewSelectChild.isHidden = true
        backgroundView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self // This is not required
        backgroundView.addGestureRecognizer(tap)
        
        viewWeeklyTestReport.isHidden = true
        viewArechiveDashboard.isHidden = true
        viewCandATest.isHidden = true
        
      
    }
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        sideBarMenuTapDismiss()
    }
    
    //Mark:- ********_viewCycle_viewWillAppear_********
    //Mark:-
    override func viewWillAppear(_ animated: Bool) {
        if userName != nil {
            lblParentNametop.text = userName as! String
        }
        if arrayUserDef != nil {
            lblChlidNameTop.text = "Parent of \(thechildName!)" as! String
            lblChlidNameForTime.text = thechildName! as! String
            lblClass.text = "Class: \(classIs!)" as! String
            lblLastActive.text = "Last Active: \(lastActive!)" as! String
            imgProfilePic.sd_setImage(with: URL(string: "\(profilPic)"))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    ///For Status bar Color Cahnge.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //Mark:- ********_Button_ACTIONS_********
    //Mark:-
    
    @IBAction func btnSchoolAtHome(_ sender: Any) {
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "goToSchoolReportVC") as! goToSchoolReportVC
        VC.screenName2 = "School at Home Reports"
         VC.videoCategory = ""
        //(gts = 1), (sah ="")
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    @IBAction func btnGotoSchool(_ sender: Any) {
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "goToSchoolReportVC") as! goToSchoolReportVC
        VC.screenName2 = "Go to School Reports"
        VC.videoCategory = "1"
        //(gts = 1), (sah ="")
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        backgroundView.isHidden = true
        viewSelectChild.isHidden = true
        scrollView.isScrollEnabled = true
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "USERID")
        UserDefaults.standard.set(selectedUserID, forKey: "USERID")
        
        UserDefaults.standard.removeObject(forKey: "CHILDNAME")
        UserDefaults.standard.set(selectedChildName, forKey: "CHILDNAME")
        
        UserDefaults.standard.removeObject(forKey: "CLASS")
        UserDefaults.standard.set(selectedClass, forKey: "CLASS")
        
        UserDefaults.standard.removeObject(forKey: "LASTACTIVE")
        UserDefaults.standard.set(selectedlastActiveOn, forKey: "LASTACTIVE")
        
        UserDefaults.standard.removeObject(forKey: "BOARDID")
        UserDefaults.standard.set(selectedBoardId, forKey: "BOARDID")
        
        UserDefaults.standard.removeObject(forKey: "CLASSID")
        UserDefaults.standard.set(selectedClassID, forKey: "CLASSID")
                
        UserDefaults.standard.removeObject(forKey: "PROFILEPIC")
        UserDefaults.standard.set(selectedProfilePic, forKey: "PROFILEPIC")
        
        lblLastActive.text = "Last Active: \(selectedlastActiveOn!)"
        lblClass.text = "Class: \(selectedClass!)"
        lblChlidNameTop.text = "Parent of \(selectedChildName!)"
        lblChlidNameForTime.text = selectedChildName!
        
        if selectedProfilePic == nil {
            imgProfilePic.image = #imageLiteral(resourceName: "profile")
            
        }
        else {
            imgProfilePic.sd_setImage(with: URL(string: selectedProfilePic!))
        }
        
        backgroundView.isHidden = true
        viewSelectChild.isHidden = true
        scrollView.isScrollEnabled = true
        ApiDashboardData()
        
    }
    
    @IBAction func btnChildDropDown(_ sender: Any) {
        backgroundView.isHidden = false
        viewSelectChild.isHidden = false
        scrollView.isScrollEnabled = false
    }
    
    @IBAction func btnAchieveDash(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "AchieveDashboardVC") as! AchieveDashboardVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnReportOverView(_ sender: Any) {
        //alert(message: "in progress")
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "PrfrmnceStOverviewVC") as! PrfrmnceStOverviewVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnQuickupdate(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)

                let VC = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                self.navigationController?.pushViewController(VC, animated: false)
        
       
//        let VC = self.storyboard?.instantiateViewController(withIdentifier: "quickUpdateVC") as! quickUpdateVC
//        self.navigationController?.pushViewController(VC, animated: false)
    }
    
    @IBAction func btnWeeklyTestRep(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "WeeklyTestPerformanceVC") as! WeeklyTestPerformanceVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnSideBar(_ sender: Any) {
        viewSelectChild.isHidden = true
        if userName != nil {
            lblUserNameis.text = userName as! String
        }
        SideBarMenu()
    }
    
    @IBAction func didTapPersonalizeJurnyBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "personalJReportVC") as! personalJReportVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

//MARK:- ******function_table_view_in_sildeBar*****
//MARK:-
extension homeScreenVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == sideBarTable {
            return arrData.count
        } else  {
            return arrayUserDef?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellToReturn = UITableViewCell() // Dummy value
        
        if tableView == sideBarTable {
            
            let cell = sideBarTable.dequeueReusableCell(withIdentifier: "sideBarTVCell") as! sideBarTVCell
            cell.imgSideBarIcon.image = arrImg[indexPath.row]
            cell.lblNameMod.text = arrData[indexPath.row]
            
            cellToReturn = cell
        }
        else if tableView == childTable {
            let cell = childTable.dequeueReusableCell(withIdentifier: "selectChildTVCell") as! selectChildTVCell
            
            let dict = self.arrayUserDef?[indexPath.row] as? NSDictionary ?? [:]
            
            let previewURL = dict.value(forKey: "profile_pic") as? String ?? ""
            let childName = dict.value(forKey: "child_name") as? String ?? ""
            
            cell.lblChildName.text = childName
            cell.imgChild.sd_setImage(with: URL(string: previewURL))
            
            cellToReturn = cell
        }
        return cellToReturn
    }
    //MARK:- ******_heightForRow_table_view*****
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == sideBarTable {
            return 55
        }
        else {
            return    72
        }
    }
    //MARK:- ******_didSelectRowAt_table_view*****
    //MARK: -
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == sideBarTable{
            if indexPath.row == 0 {
                let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
                selectedCell.contentView.backgroundColor = .blue
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "stepsToAddChlidVC") as! stepsToAddChlidVC
                self.navigationController?.pushViewController(VC, animated: true)
            }
            else if indexPath.row == 1 {
                let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
                selectedCell.contentView.backgroundColor = .blue
                alert(message: "Coming soon")
            }
                else if indexPath.row == 2 {
                let storyBord = UIStoryboard(name: "Home", bundle: nil)
                let VC = storyBord.instantiateViewController(withIdentifier: "RateUsVC") as! RateUsVC
                self.navigationController?.present(VC, animated: true, completion: nil)
            }
                
            else if indexPath.row == 3 {
                let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
                selectedCell.contentView.backgroundColor = .blue
                
                //MARK:- _**********_Func_Logout_*******
                //MARK:-
                showActivityIndicator()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginVC
                    UserDefaults.standard.removeObject(forKey: "USERID")
                    UserDefaults.standard.removeObject(forKey: "NAME")
                    UserDefaults.standard.removeObject(forKey: "CLASSID")
                    UserDefaults.standard.removeObject(forKey: "BOARDID")
                    UserDefaults.standard.removeObject(forKey: "CHILDNAME")
                    UserDefaults.standard.removeObject(forKey: "ARRCHILD")
                    UserDefaults.standard.removeObject(forKey: "CLASS")
                    UserDefaults.standard.removeObject(forKey: "LASTACTIVE")
                    UserDefaults.standard.removeObject(forKey: "PROFILEPIC")
                    UserDefaults.standard.removeObject(forKey: "SCHOOLID")
                    UserDefaults.standard.removeObject(forKey: "SECTION")
                    UserDefaults.standard.removeObject(forKey: "SECTIONID")
                    UserDefaults.standard.removeObject(forKey: "PEMAIL")
                    UserDefaults.standard.removeObject(forKey: "PMOBILE")
                    UserDefaults.standard.removeObject(forKey: "USERNAME")
                    UserDefaults.standard.removeObject(forKey: "PASSWORD")
                    
                   
                    
                   
                    
                    self.navigationController?.pushViewController(VC, animated: true)
                }
            }
        }
        else if  tableView == childTable{
            
            //           let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
            //           selectedCell.contentView.backgroundColor = #colorLiteral(red: 0.8626691699, green: 0.862793684, blue: 0.8626419902, alpha: 1)
            let dict = self.arrayUserDef?[indexPath.row] as? NSDictionary ?? [:]
            let childUserId = dict.value(forKey: "child_user_id") as? String ?? ""
            let childName = dict.value(forKey: "child_name") as? String ?? ""
            let TheClass = dict.value(forKey: "class") as? String ?? ""
            let ThelastActiveOn = dict.value(forKey: "last_active_on") as? String ?? ""
            let boardId = dict.value(forKey: "board_id") as? String ?? ""
            let classId = dict.value(forKey: "class_id") as? String ?? ""
            let profilePic = dict.value(forKey: "profile_pic") as? String ?? ""
            
            selectedUserID = childUserId
            selectedChildName = childName
            selectedClass = TheClass
            selectedlastActiveOn = ThelastActiveOn
            selectedBoardId = boardId
            selectedClassID = classId
            selectedProfilePic = profilePic

        }
    }
    
    
    //MARK:- ******_didDeselectRowAt_table_view*****
    //MARK:
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if tableView == sideBarTable {
            if indexPath.row == 0 {
                let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
                selectedCell.contentView.backgroundColor = .clear
            }
            else if indexPath.row == 1 {
                let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
                selectedCell.contentView.backgroundColor = .clear
            }
            else if indexPath.row == 2 {
                let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
                selectedCell.contentView.backgroundColor = .clear
            }
        }
        else {
            //            let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
            //            selectedCell.contentView.backgroundColor = .clear
        }
    }
}

//MARK:- ******_func_gradiantCrop_*****
//MARK:-
extension homeScreenVC {
    func gradiantCrop() {
        bullet1.applyGradient(colours: [UIColor(red: 76.0/255.0, green: 216.0/255.0, blue: 154.0/255.0, alpha: 1.0), UIColor(red: 116.0/255.0, green: 246.0/255.0, blue: 207.0/255.0, alpha: 0.73)])
        
        bullet2.applyGradient(colours: [UIColor(red: 238.0/255.0, green: 89.0/255.0, blue: 110.0/255.0, alpha: 1.0), UIColor(red: 231.0/255.0, green: 126.0/255.0, blue: 119.0/255.0, alpha: 1.0)])
        
        bullet1.layer.cornerRadius = bullet1.frame.size.width / 2
        bullet1.clipsToBounds = true
        bullet2.layer.cornerRadius = bullet2.frame.size.width / 2
        bullet2.clipsToBounds = true
        bullet3.layer.cornerRadius = bullet3.frame.size.width / 2
        bullet3.clipsToBounds = true
        viewTodayTime.layer.cornerRadius = viewTodayTime.frame.size.width / 2
        viewTodayTime.clipsToBounds = true
        viewArechiveDashboard.gradientBlueWithCornerRadius()
        viewWeeklyTestReport.gradientBlueWithCornerRadius()
        viewSchoolAtHome.gradientBlueWithCornerRadius()
        viewPJReprt.gradientBlueWithCornerRadius()
        viewCandATest.gradientBlueWithCornerRadius()
        viewPrentTeacher.gradientBlueWithCornerRadius()
        viewChildConnect.gradientBlueWithCornerRadius()
        viewGoToSchool.gradientBlueWithCornerRadius()
        
        viewPerformaceStatistics.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        viewPerformaceStatistics.cornerRadius = 10
        viewPerformaceStatistics.borderWidth = 2
        
        viewSubjWisePerformace.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        viewSubjWisePerformace.cornerRadius = 10
        viewSubjWisePerformace.borderWidth = 2
        
        viewBloom.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        viewBloom.cornerRadius = 10
        viewBloom.borderWidth = 2
        
        viewTimeInapp.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        viewTimeInapp.cornerRadius = 10
        viewTimeInapp.borderWidth = 2
                
        btnCancel.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        btnCancel.layer.borderWidth = 1.5
        
        imgProfilePic.layer.cornerRadius = imgProfilePic.frame.size.width / 2
        imgProfilePic.clipsToBounds = true
    }
}

//MARK:- ****************_Func_ side_bar()******
//MARK:-
extension homeScreenVC {
    func SideBarMenu() {
        if (mySlideMenu) {
            leadingConstrain.constant = -240
            backgroundView.isHidden = true
        }
        else {
            leadingConstrain.constant = 0
            backgroundView.isHidden = false
            scrollView.isScrollEnabled = false
            backgroundView.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0.1, options: curveEaseIn , animations: {
                self.view.layoutIfNeeded()
            })
        }
        mySlideMenu = !mySlideMenu
    }
    //mark:- func_*********_func dissmiss_on_backgroundViewTap_
    func sideBarMenuTapDismiss(){
        
        if (mySlideMenu) {
        }
        else {
            leadingConstrain.constant = -240
            backgroundView.isHidden = true
            viewSelectChild.isHidden = true
            UIView.animate(withDuration: 0.3, delay: 0.1, options: curveEaseIn , animations: {
                self.view.layoutIfNeeded()
            })
            scrollView.isScrollEnabled = true
        }
        mySlideMenu = !mySlideMenu
    }
}

//MARK:- ******_collectionView_*****
//MARK:-

extension homeScreenVC {
    func  ApiDashboardData() {
        var action = "get_parent_dashboard"
//        var Salt = "p@rentapp$ios@!2019"
//        var apiKey = "8DDAD308E555C2AA38BFF8DBE"
        let isNewApp = 1
        
        var UserId = UserDefaults.standard.value(forKey: "USERID")
        var ClassId = UserDefaults.standard.value(forKey: "CLASSID")
        var BoardId = UserDefaults.standard.value(forKey: "BOARDID")
        let checkSumValues =  "\(BoardId!):\(ClassId!):\(isNewApp):\(UserId!):\(action):\(apikeyMain):\(saltMain)"
        let myCheckString = MD5(checkSumValues)
        
        print("checksum values to convert",checkSumValues)
        print("converted chceksum string",myCheckString)
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        print("the selected userId",UserId)
        print("the ClassId is",ClassId)
        print("the ClassId is",BoardId)
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("\(baseUrl)v1.1/subjectwiseprogressreportindo?board_id=\(BoardId!)&class_id=\(ClassId!)&is_new_app=1&user_id=\(UserId!)&report_type=get_parent_dashboard&apikey=\(apikeyMain)&checksum=\(myCheckString!)", method: .get, encoding: JSONEncoding.default, headers: headers)
                
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            
                            self.hideActivityIndicator()
                            print("THE JSON RESULT",JSON)
                            
                            let message = JSON["message"] as? String ?? ""
                            print("the message is",message)
                            
                            if message == "success" {                                      self.hideActivityIndicator()
                                
                              //MARK:-Color Graphloader shows correct,wrong skipped value
                                //
                                self.dicPerformanceStats = JSON["performance_stats"] as? NSDictionary ?? [:]
                                let totalTests = self.dicPerformanceStats.value(forKey: "total_tests") as? Int ?? 0
                                let overallaProgress = self.dicPerformanceStats.value(forKey: "overall_progress") as? Int ?? 0
                                
                                let correctAnswers = self.dicPerformanceStats.value(forKey: "correct_answers") as? Int ?? 0
                                let wrongAnswers = self.dicPerformanceStats.value(forKey: "wrong_answers") as? Int ?? 0
                                var skippedQuetions = self.dicPerformanceStats.value(forKey: "skipped_quetions") as? Int ?? 0
                                
                                self.lblTotaltests.text = "\(totalTests)"
                                self.lblCorrectAnswer.text = "\(correctAnswers)"
                                self.lblWrongAnswer.text = "\(wrongAnswers)"
                                self.lblSkippedQuestions.text = "\(skippedQuetions)"
                                self.lblOverAllProgress.text = "\(overallaProgress) %"
                                
                                var arcArray: [Arc] = [Arc]()
                                arcArray.append(Arc(c: #colorLiteral(red: 0.4033602476, green: 0.8931822777, blue: 0.6872150898, alpha: 1), v: Double(correctAnswers) ))
                                arcArray.append(Arc(c: #colorLiteral(red: 0.9218646884, green: 0.4113363922, blue: 0.4478791952, alpha: 1), v: Double(wrongAnswers)))
                                arcArray.append(Arc(c: #colorLiteral(red: 0.5921034217, green: 0.5921911597, blue: 0.592084229, alpha: 1), v: Double(skippedQuetions)))
                                self.viewGraphLoader.Start(array: arcArray, lWidth: 8.0)
                                     
                                //MARK:-***Collection view subjectcell
                                //
                                self.dicOverallPerformance = JSON["overall_performance"] as? NSArray ?? []
                                //***
                                
                    //MARK:- ***_"school_details" values for GotoSchool_ module***
                     //MARK:-
                                self.schoolDetails = JSON["school_details"] as? NSDictionary ?? [:]
                                let schoolName = self.schoolDetails.value(forKey: "school_name") as? String ?? ""
                                let schoolAddress = self.schoolDetails.value(forKey: "school_address") as? String ?? ""
                                let schoolId = self.schoolDetails.value(forKey: "school_id") as? String ?? ""
                                let section = self.schoolDetails.value(forKey: "section") as? String ?? ""
                                let sectionId = self.schoolDetails.value(forKey: "section_id") as? String ?? ""
                                
                                UserDefaults.standard.set(schoolId, forKey: "SCHOOLID")
                                UserDefaults.standard.set(section, forKey: "SECTION")
                                UserDefaults.standard.set(sectionId, forKey: "SECTIONID")
                                var UserId = UserDefaults.standard.value(forKey: "USERID")
                                print("my UserId is",UserId)
// user_id  :   studnet_type:  boardId   :  classId   : action   : "10" : subjectId : SALT   : API KEY

                                
                                var schoolID = UserDefaults.standard.value(forKey: "SCHOOLID")
                                var section2 = UserDefaults.standard.value(forKey: "SECTION")
                                var sectionID = UserDefaults.standard.value(forKey: "SECTIONID")
                                print("schoolID in api",schoolID)
                                print("section in api",section)
                                print("sectionID in api",sectionID)
                                
                                //schoolID after selection
                                //schoolDetails in didselect
                                //Optional(37137)

                                self.lblSchoolAddress.text = "Address:\(schoolAddress)"
                                if schoolName == "" {
                                    self.lblSchoolName.text = "School: \(schoolName)"
                                }
                                else {
                                    self.lblSchoolName.text = schoolName
                                }
                                
                                
                           //-********************
                                
                      //MARK:- ***_"school_at_home" values for SchoolAtHome_module***
                     //MARK:-
                                
                                let dictSchool_at_home = JSON["school_at_home"] as? NSDictionary ?? [:]
                                
                                let batchStartMsg = dictSchool_at_home.value(forKey: "batch_start_msg") as? String ?? ""
                                self.lblStartInSchoolAtHome.text = "\(batchStartMsg)"
                     //-********************
                                
                                //MARK:-**Blooms Loader Values
                                //ssxs
                                let arrBlooms = JSON["blooms"] as? NSArray ?? []
                                print("arrBlooms is",arrBlooms)
                                print("arrBlooms count is",arrBlooms.count)
                                
                                
                                self.lblBloom1.text = ""
                                self.lblBloomTotal1.text = ""
                                self.lblBloom2.text = ""
                                self.lblBloomTotal2.text = ""
                                self.lblBloom3.text = ""
                                self.lblBloomTotal3.text = ""
                                self.lblBloom4.text = ""
                                self.lblBloomTotal4.text = ""
                                self.lblBloom5.text = ""
                                self.lblBloomTotal5.text = ""
                                self.lblBloom6.text = ""
                                self.lblBloomTotal6.text = ""
                                if arrBlooms.count != 0 {
                                    var indx = 0
                                    for x in arrBlooms{
                                        indx += 1
                                        let dataDict = x as? NSDictionary ?? [:]
                                        
                                        let categoryName = dataDict.value(forKey: "category_name") as? String ?? ""
                                        
                                        let totalQues = dataDict.value(forKey: "total_questions") as? Int ?? 0
                                        let correctAns = dataDict.value(forKey: "correct_ans") as? Int ?? 0
                                        
                                        if indx == 1{
                                            self.lblBloom1.text = "\(correctAns)"
                                            self.lblBloomTotal1.text = "\(totalQues)"
                                        }
                                        if indx == 2{
                                            self.lblBloom2.text = "\(correctAns)"
                                            self.lblBloomTotal2.text = "\(totalQues)"
                                        }
                                        
                                        if indx == 3{
                                            self.lblBloom3.text = "\(correctAns)"
                                            self.lblBloomTotal3.text = "\(totalQues)"
                                        }
                                        
                                        if indx == 4{
                                            self.lblBloom4.text = "\(correctAns)"
                                            self.lblBloomTotal4.text = "\(totalQues)"
                                            
                                        }
                                        if indx == 5{
                                            self.lblBloom5.text = "\(correctAns)"
                                            self.lblBloomTotal5.text = "\(totalQues)"
                                            
                                        }
                                        if indx == 6{
                                            self.lblBloom6.text = "\(correctAns)"
                                            self.lblBloomTotal6.text = "\(totalQues)"
                                            
                                        }
                                        
                                        print("the category Name is",categoryName)
                                        print("totalQues is", totalQues)
                                        print("correctAns is", correctAns)
                                        
                                    }
                               }
                                
                                self.collectionView.reloadData()
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


//MARK:- ******_collectionView_*****
//MARK:-
extension homeScreenVC {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //self.collectionView.reloadData()
        
        print("count in collectiolview",dicOverallPerformance.count)
        return dicOverallPerformance.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCVCell", for: indexPath) as! dashboardCVCell
        
        let dataDict = self.dicOverallPerformance.object(at: indexPath.row) as? NSDictionary ?? [:]
        let subjectIcon = dataDict.value(forKey: "subject_icon") as? String ?? ""
        let subjectName = dataDict.value(forKey: "subject_name") as? String ?? ""
        let subjectColorCode = dataDict.value(forKey: "subject_color_code") as? String ?? ""
        
        cell.lblSubName.text = subjectName
        cell.imgSubject.sd_setImage(with: URL(string: subjectIcon))
        cell.imgSubject.backgroundColor = UIColor.init(hexString: subjectColorCode)
        cell.imgSubject.layer.cornerRadius = cell.imgSubject.frame.size.width / 2
        cell.imgSubject.clipsToBounds = true
        print("subjectIcon",subjectIcon)
        print("subjectIcon",subjectName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataDict = self.dicOverallPerformance.object(at: indexPath.row) as? NSDictionary ?? [:]
        print("dataDict is:-", dataDict)
        let subjectId = dataDict.value(forKey: "subject_id") as? Int ?? 0
        print("subjectId is:-", subjectId)
        
        let subName = dataDict.value(forKey: "subject_name") as? String ?? ""
        print("subName is:-", subName)
        let storyBord = UIStoryboard(name: "Home", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "SubjectWisePerformanceVC") as! SubjectWisePerformanceVC
        VC.subId = subjectId
        VC.subjectName = subName
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
    //    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/3, height: collectionViewWidth/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
