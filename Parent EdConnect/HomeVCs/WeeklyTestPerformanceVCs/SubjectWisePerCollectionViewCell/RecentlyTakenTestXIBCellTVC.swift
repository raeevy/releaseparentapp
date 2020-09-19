//
//  RecentlyTakenTestXIBCellTVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/23/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class RecentlyTakenTestXIBCellTVC: UITableViewCell {
    
    
    @IBOutlet weak var viewUpperCircular: UIView!
    @IBOutlet weak var lblTaskNameShow: UILabel!
    @IBOutlet weak var btnAnalyse: UIButton!
    @IBOutlet weak var viewBottomLine: UIView!
    @IBOutlet weak var lblShowPercentage: UILabel!
    @IBOutlet weak var viewCircular: CircularArc!
    
    var parentVC:SubjectWisePerformanceVC?
    var chapName:String?
    var subjestId:Int?
    var chapterId:String?
    var testId:String?
    
    var correctAnswers:String?
    var incorrectAnswers:String?
    var skippedQuestions:String?
    var overallProgress:Double?
    
    var dictdata:NSDictionary?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        self.btnAnalyse.gradientYellow()
        self.btnAnalyse.cornerRadius()
    }
    
    @IBAction func didTapAnalizeBtn(_ sender: UIButton) {
        let storyBord = UIStoryboard(name: "Home", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "StructureOfAtomsVC") as! StructureOfAtomsVC
        
        
//        cell.correctAnswers = dict.value(forKey: "correct_answers") as? String ?? ""
//               cell.incorrectAnswers = dict.value(forKey: "incorrect_answers") as? String ?? ""
//               cell.overallProgress = dict.value(forKey: "overall_progress") as? Double ?? 0.0
//               cell.skippedQuestions = dict.value(forKey: "skipped_questions") as? String ?? ""
//
//
//               print("incorrectAnswers is:-", cell.incorrectAnswers)
//               print("overallProgress is:-", cell.overallProgress)
//               print("skippedQuestions is:-", cell.skippedQuestions)
//               print("correctAnswers is:-", cell.correctAnswers)
        
        VC.dictDataP = self.dictdata
        VC.chapterId = self.chapterId
        VC.testId = self.testId
        VC.subjestId = self.subjestId
        VC.chapNameRecently = self.chapName
        self.parentVC?.navigationController?.pushViewController(VC, animated: true)
    }
    
}
