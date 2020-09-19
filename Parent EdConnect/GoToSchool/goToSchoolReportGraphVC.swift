//
//  goToSchoolReportGraphVC.swift
//  Parent EdConnect
//
//  Created by Work on 27/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire
import Highcharts

class goToSchoolReportGraphVC: UIViewController {
    
    var screenName:String?
    var weekAssigned:Int?
    var weekAttempted:Int?
    //    var videoCategory:String?
    
    var arrAssessmentReports2 = NSArray()
    var dicLiveClassReports2 = NSDictionary()
    var arrLiveClassAttendance2 = NSArray()
    
    
    var  arrAttended = NSMutableArray()
    var  arrDate = NSMutableArray()
    var  arrNotAttended = NSMutableArray()
    
    
    let colors: [HIColor] = [
        HIColor(rgba: 38, green: 95, blue: 196, alpha: 1),
        HIColor(rgba: 249, green: 141, blue: 32, alpha: 1)
    ]
    
   
    
    
    //MARK:- ********_OUTLETS_*******
    //MARK:-
    
    @IBOutlet weak var liveClassChartView: HIChartView!
    @IBOutlet weak var dChartView: HIChartView!
    @IBOutlet weak var lblScreenName: UILabel!
    @IBOutlet weak var viewLiveClassReport: CustomView!
    @IBOutlet weak var viewWorksheet: CustomView!
    @IBOutlet weak var viewHomewwork: CustomView!
    @IBOutlet weak var viewWeeklyTestReport: CustomView!
    @IBOutlet weak var circleAttended: UIView!
    @IBOutlet weak var circleUnAttended: UIView!
    
    @IBOutlet weak var lblLiveClassDate: UILabel!
    
    @IBOutlet weak var lblLiveAttended: UILabel!
    
    
    @IBOutlet weak var lblByLecture: UILabel!
    
    @IBOutlet weak var lblLiveUnAttended: UILabel!
    
    @IBOutlet weak var lblLiveClassSub: UILabel!
    
    
    @IBOutlet weak var lblLiveClassStartIn: UILabel!
    
    //MARK:- ********_ViewDidLoad_*******
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        cropAndGradient()
        StatusBarSetup()
        print("arrAssessmentReports2 is",self.arrAssessmentReports2)
        print("dicLiveClassReports2 is",self.dicLiveClassReports2)
        
    }
    //MARK:- ********_viewWillAppear_*******
    //MARK:-
    override func viewWillAppear(_ animated: Bool) {
        lblScreenName.text = screenName
        dataImplementOnGraph()
        //UserDefaults.standard.set(videoCategory, forKey: "VIDEOCATEGORY")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        chartLiveClass()
        chart3D()
    }
    //Status bar content
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- ********_buttonAction_*******
    //MARK:-
    @IBAction func btnBack(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "VIDEOCATEGORY")
        self.navigationController?.backToViewController(viewController: homeScreenVC.self)
    }
    
    @IBAction func btnViewLiveClassReport(_ sender: Any) {
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "liveClassReportVC") as! liveClassReportVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnToggle(_ sender: Any) {
        
        self.navigationController?.backToVCWithoutAnimation(viewController: goToSchoolReportVC.self)
        
//        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
//        let VC = storyBord.instantiateViewController(withIdentifier: "goToSchoolReportVC") as! goToSchoolReportVC
//        VC.screenName2 =  screenName
//        self.navigationController?.pushViewController(VC, animated: false)
    }
    
    @IBAction func btnWorksheet(_ sender: Any) {
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "worksheetHomeworkWeeklyOverviewVC") as! worksheetHomeworkWeeklyOverviewVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnHomework(_ sender: Any) {
        
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "worksheetHomeworkWeeklyOverviewVC") as! worksheetHomeworkWeeklyOverviewVC
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func btnWeeklyTestReport(_ sender: Any) {
        let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "worksheetHomeworkWeeklyOverviewVC") as! worksheetHomeworkWeeklyOverviewVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
//MARK:- ********_UI_Implementation_*******
//MARK:-
extension goToSchoolReportGraphVC {
    func cropAndGradient() {
        circleAttended.applyGradient(colours: [UIColor(red: 76.0/255.0, green: 216.0/255.0, blue: 154.0/255.0, alpha: 1.0), UIColor(red: 116.0/255.0, green: 246.0/255.0, blue: 207.0/255.0, alpha: 0.73)])
        circleUnAttended.applyGradient(colours: [UIColor(red: 238.0/255.0, green: 89.0/255.0, blue: 110.0/255.0, alpha: 1.0), UIColor(red: 231.0/255.0, green: 126.0/255.0, blue: 119.0/255.0, alpha: 1.0)])
        
        circleAttended.layer.cornerRadius = circleAttended.frame.size.width / 2
        circleAttended.clipsToBounds = true
        circleUnAttended.layer.cornerRadius = circleUnAttended.frame.size.width / 2
        circleUnAttended.clipsToBounds = true
        
        viewLiveClassReport.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        viewLiveClassReport.cornerRadius = 10
        viewLiveClassReport.borderWidth = 2
        
        viewHomewwork.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        viewHomewwork.cornerRadius = 10
        viewHomewwork.borderWidth = 2
        viewWorksheet.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        viewWorksheet.cornerRadius = 10
        viewWorksheet.borderWidth = 2
        
        viewWeeklyTestReport.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        viewWeeklyTestReport.cornerRadius = 10
        viewWeeklyTestReport.borderWidth = 2
    }
}

//MARK:- *********_Graphs_***********
//MARK:-
extension goToSchoolReportGraphVC {
    
    func chart3D() {
        
        let options = HIOptions()
        let chart = HIChart()
        
        let options2 = HIOptions()

        let chart2 = HIChart()
        
        chart.type = "pie"
        chart.options3d = HIOptions3d()
        chart.options3d.enabled = NSNumber(value: true)
        chart.options3d.alpha = NSNumber(value: 45)
        chart.options3d.beta = NSNumber(value: 0)
        
        let title = HITitle()
        title.text = ""
        
        let plotoptions = HIPlotOptions()
        plotoptions.pie = HIPie()
        plotoptions.pie.depth = NSNumber(value: 35)
         
        let pie = HIPie()
        
        if weekAssigned! != nil || weekAssigned! != 0 || weekAttempted! != nil || weekAttempted! != 0 {
            pie.data = [
                ["\(weekAssigned!)", NSNumber(value: weekAssigned!)],
                ["\(weekAttempted!)", NSNumber(value: weekAttempted!)]
            ]
        }
           
        print("weekAssigned for graph",weekAssigned)
        print("weekAttempted for graph",weekAttempted)
        
        pie.name = ""
        pie.colors = colors
        options.chart = chart
        options.title = title
        options.plotOptions = plotoptions
        options.series = [pie]
        
        dChartView.options = options
    }
    
    
    func chartLiveClass() {
        
        let options2 = HIOptions()
        let chart2 = HIChart()
        
        chart2.type = "line"

        let title = HITitle()
        title.text = "Monthly Average Temperature"

        let subtitle = HISubtitle()
        subtitle.text = ""

        let xaxis = HIXAxis()
        xaxis.categories = arrDate as! [String]

        let yaxis = HIYAxis()
        yaxis.title = HITitle()
        yaxis.title.text = ""

        let plotoptions = HIPlotOptions()
        plotoptions.line = HILine()
       

        let line1 = HILine()
     
        line1.color = HIColor(rgba: 237, green: 92, blue: 111, alpha: 1)
        line1.data = arrAttended as! [Any]

        let line2 = HILine()
        line2.color = HIColor(rgba: 49, green: 194, blue: 130, alpha: 1)
        
        line2.data = arrNotAttended as! [Any]

        options2.chart = chart2
        options2.title = title
        options2.subtitle = subtitle
        options2.xAxis = [xaxis]
        options2.yAxis = [yaxis]
        options2.plotOptions = plotoptions
        options2.series = [line1, line2]
        
         liveClassChartView.options = options2;
        
    }
    
}

extension goToSchoolReportGraphVC {
    
    func dataImplementOnGraph() {
        
        //:- weekly,homework, worksheet
        //:-
        let dictWeeklyTest = self.arrAssessmentReports2.object(at: 0) as? NSDictionary ?? [:]
        let dictWorkSheet = self.arrAssessmentReports2.object(at: 1) as? NSDictionary ?? [:]
        let dictHomework = self.arrAssessmentReports2.object(at: 2) as? NSDictionary ?? [:]

        let weekAssigned = dictWeeklyTest.value(forKey: "assigned") as? Int ?? 0
        let weekAttempted = dictWeeklyTest.value(forKey: "attempted") as? Int ?? 0
        
        print("weekAssigned is",weekAssigned)
        print("weekAttempted is",weekAttempted)
        
        self.weekAssigned = weekAssigned
        self.weekAttempted = weekAttempted
        
        let workAssigned = dictWorkSheet.value(forKey: "assigned") as? Int ?? 0
        let workAttempted = dictWorkSheet.value(forKey: "attempted") as? Int ?? 0
        
        let homeAssigned = dictHomework.value(forKey: "assigned") as? Int ?? 0
        let homeAttempted = dictHomework.value(forKey: "attempted") as? Int ?? 0
        
        //:-liveclass_value
        //:-
        let liveClassSub = self.dicLiveClassReports2.value(forKey: "upcoming_live_class_subject_name") as? String ?? ""
        
        let liveClassStartIn = self.dicLiveClassReports2.value(forKey: "upcoming_live_class_starts_in") as? String ?? ""
        
        let liveClassBy = self.dicLiveClassReports2.value(forKey: "upcoming_live_class_faculty_name") as? String ?? ""
       
        
        
        print("arrLiveClassAttendance2 Is",arrLiveClassAttendance2)
        
        

        for (index, element) in arrLiveClassAttendance2.enumerated() {
            
            let dataDict = arrLiveClassAttendance2.object(at: index) as? NSDictionary ?? [:]
            
            let date1 = dataDict.value(forKey: "date") as? String ?? ""
            let attended = dataDict.value(forKey: "attended") as? Int ?? 0
            let notAttended = dataDict.value(forKey: "not_attended") as? Int ?? 0
            
            
            self.arrDate.add(date1)
            self.arrAttended.add(attended)
            self.arrNotAttended.add(notAttended)
                        }
        print("arrDate is",self.arrDate.lastObject)
        print("arrAttended is",self.arrAttended)
        print("arrNotAttended is",self.arrNotAttended)
        
        let fromDate = self.arrDate.firstObject as? String
        let fromDate2 = fromDate?.suffix(2)
        
        let toDate = self.arrDate.lastObject
        
        if fromDate2 != nil && toDate != nil {
            lblLiveClassDate.text = "\(fromDate2!) - \(toDate!)"
        }
        
        
        var totalAttend = 0
        for i in arrAttended {
            totalAttend += i as! Int
        }
        
        lblLiveAttended.text = "\(totalAttend) Attended"
        
        
        var totalNotAttent = 0
               for i in arrNotAttended {
                   totalNotAttent += i as! Int
               }
        
        lblLiveUnAttended.text = "\(totalNotAttent) Unattended"
        
        
        lblByLecture.text = "By: \(liveClassBy)"
        lblLiveClassSub.text = "Note: \(liveClassSub) Lecture"
        lblLiveClassStartIn.text = "Start In: \(liveClassStartIn)"
    }
}
