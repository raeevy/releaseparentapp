//
//  hIghLowestScoreVC.swift
//  Parent EdConnect
//
//  Created by Work on 01/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class hIghLowestScoreVC: UIViewController {
    
    var subDict = NSDictionary()
    var screenName:String?
    
    @IBOutlet weak var lblMinsPerTest: UILabel!
    @IBOutlet weak var lblAccuracyLevel: UILabel!
    
    
    @IBOutlet weak var lblTotalTimeSpent: UILabel!
    
    @IBOutlet weak var bulletMe: UIImageView!
    
    @IBOutlet weak var bulletAvrUser: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var viewAccuracyLevel: CircularView!
    @IBOutlet weak var viewAvrgTestDuration: CircularView!
    @IBOutlet weak var viewScoreComaparision: CustomView!
    
    @IBOutlet weak var barTotalTest: BarChartView!
    @IBOutlet weak var barTestScore: BarChartView!
    
    @IBOutlet weak var lblStatusScoreSub: UILabel!
    @IBOutlet weak var viewStatistics: UIView!
    
    @IBAction func tapBack(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    
    //Mark:- ********__viewCycle_viewDidload_********
    //Mark:-
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        StatusBarSetup()
        print("subDict is",subDict)
        
    }
   
       override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    
    override func viewWillAppear(_ animated: Bool) {
        if screenName == "0" {
            lblStatusScoreSub.text = "Highest Score Subject"
        }
        else if screenName == "1" {
            lblStatusScoreSub.text = "Lowest Score Subject"
        }
        loadUi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        barAndLoader()
    }
}

//MARK:- ************_implementing_UI_*****************
//MARK:-
extension hIghLowestScoreVC{
    func loadUi() {
      
        viewAvrgTestDuration.backgroundColor = .clear
        viewAccuracyLevel.backgroundColor = .clear
        
        lbl1.backgroundColor = .clear
        lbl2.backgroundColor = .clear
        
        viewScoreComaparision.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        viewScoreComaparision.cornerRadius = 10
        viewScoreComaparision.borderWidth = 2
        viewStatistics.gradientBlueWithCornerRadius()
        //lblMinsPerTest.backgroundColor = .clear
        //lblStatusScoreSub.backgroundColor = .clear
        
        bulletMe.layer.cornerRadius = bulletMe.frame.size.width / 2
        bulletMe.clipsToBounds = true
        
        bulletAvrUser.layer.cornerRadius = bulletAvrUser.frame.size.width / 2
        bulletAvrUser.clipsToBounds = true
    }
}


extension hIghLowestScoreVC {
    func barAndLoader() {
        let average_score = subDict.value(forKey: "average_score") as? Double ?? 0.0
              
              // MAIN-dict short report
              //
              let short_report = subDict.value(forKey: "short_report") as? NSDictionary ?? [:]
              
              // 1:- dict no of test
              //
              let  dictNoOfTests = short_report.value(forKey: "no_of_tests") as? NSDictionary ?? [:]
              
              let  yourTestCount = dictNoOfTests.value(forKey: "your_test_count") as? String ?? ""
              let  anotherUserTestCount = dictNoOfTests.value(forKey: "another_user_test_count") as? String ?? ""
              
              let FyourTestCount = Float(yourTestCount) ?? 0.0
              let FanotherUserTestCount = Float(anotherUserTestCount) ?? 0.0
              
              // 2:-dic test score
              //
              let  dictTestscore = short_report.value(forKey: "nilai_tes") as? NSDictionary ?? [:]

              let  yourScore = dictTestscore.value(forKey: "your_score") as? String ?? ""
              let  otherScore = dictTestscore.value(forKey: "other_score") as? Double ?? 0.0
              
               let FyourScore = Float(yourScore) ?? 0.0
               let FotherScore = Float(otherScore) ?? 0.0
              
              // 3:-dict question base analysis
              //
              let  dictQuesBaseAnalysis = short_report.value(forKey: "question_base_analysis") as? NSDictionary ?? [:]
              
              let  aveTestDuration = dictQuesBaseAnalysis.value(forKey: "average_test_duration") as? Double ?? 0.0
              let  totalAccuracy = dictQuesBaseAnalysis.value(forKey: "total_accuracy") as? Double ?? 0.0
              let  totalMinutes = dictQuesBaseAnalysis.value(forKey: "total_minutes") as? Double ?? 0.0
            
              let accuracyLevel = totalMinutes * totalAccuracy
               

              barTotalTest.SetBar(value1: FyourTestCount, value2: FanotherUserTestCount,multipl: 1)
              barTestScore.SetBar(value1: FyourScore, value2: FotherScore,multipl: 1)
              
              viewAccuracyLevel.Start(value: accuracyLevel, color: UIColor.orange)
              viewAvrgTestDuration.Start(value: aveTestDuration, color: UIColor.orange)
              lblTotalTimeSpent.text = "\(totalMinutes) Hours"
              lblAccuracyLevel.text = "\(accuracyLevel) %"
              lblMinsPerTest.text = "\(aveTestDuration) min/test"
              
              

    }
}
