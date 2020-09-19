//
//  subjectWiseAnalysis.swift
//  Parent EdConnect
//
//  Created by Work on 13/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class subjectWiseAnalysis: UIViewController {
    
    var subname:String?
    var score:String?
    var screenReuse:Int?
    
    
   
    @IBOutlet weak var lblScreenName: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblWorksheetNmae: UILabel!
    @IBOutlet weak var lblFeedBack: UILabel!
    @IBOutlet weak var viewScore: UIView!
    @IBOutlet weak var btnStudentResponse: UIButton!
    @IBOutlet weak var btnEvaluatedWorksheet: UIButton!
        
    
    //Subject wise Analysis
    // Worksheet Name1
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StatusBarSetup()
        cropShadow()
        
        if  screenReuse == 0 {
            btnEvaluatedWorksheet.isEnabled = true
            
            lblScreenName.text = "Subject wise Analysis"
            if subname != nil {
                lblWorksheetNmae.text = subname!
            }
            if score != nil {
                lblScore.text = score!
            }
        } else if screenReuse == 1 {
            lblScreenName.text = "Physics"
            btnEvaluatedWorksheet.isEnabled = false
            lblWorksheetNmae.text = "Electric Charges and Fields"
            lblScore.text = "28/"
            lblFeedBack.text = "Good!!! Keep going. You are an excellient performaer."
        }
     
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnStudentResponse(_ sender: Any) {
    }
    @IBAction func btnEvaluatedWorksheet(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "AchieveDash", bundle:nil)
               let VC = storyBoard.instantiateViewController(withIdentifier: "evaluatedWorksheetVC") as! evaluatedWorksheetVC
               self.navigationController?.pushViewController(VC, animated: true)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
         }
}

extension subjectWiseAnalysis {
    func cropShadow() {
        btnStudentResponse.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btnStudentResponse.layer.borderWidth = 1.5
        btnStudentResponse.layer.cornerRadius = 18.0
        btnStudentResponse.layer.masksToBounds = true;
        
        btnEvaluatedWorksheet.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btnEvaluatedWorksheet.layer.borderWidth = 1.5
        btnEvaluatedWorksheet.layer.cornerRadius = 18.0
        btnEvaluatedWorksheet.layer.masksToBounds = true;
        
        viewScore.gradientPurple()
        viewScore.layer.cornerRadius = viewScore.frame.size.width / 2
        viewScore.clipsToBounds = true
    }

}


