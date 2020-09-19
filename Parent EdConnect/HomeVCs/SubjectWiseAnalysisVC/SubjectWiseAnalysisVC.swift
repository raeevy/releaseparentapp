//
//  SubjectWiseAnalysisVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/9/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class SubjectWiseAnalysisVC: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var viewScoreCircular: UIView!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblShowScore: UILabel!
    @IBOutlet weak var lblWorkSheetName: UILabel!
    @IBOutlet weak var lblMentorFeedback: UILabel!
    @IBOutlet weak var textViewFeedBack: UITextView!
    @IBOutlet weak var btnStudentResponce: UIButton!
    @IBOutlet weak var btnEvaluationSheet: UIButton!
    
    
    
    ///Mark:-Status Bar Change
    override var preferredStatusBarStyle: UIStatusBarStyle {
                 return .lightContent
           }
    
    ///MARK:- View LifeCycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.StatusBarSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
  
    
    ///MARK:- Setup View.
    func setupView()  {
        self.viewScoreCircular.layer.cornerRadius = 45.0
        self.btnEvaluationSheet.layer.borderWidth = 2
        self.btnEvaluationSheet.layer.borderColor =  UIColor.white.cgColor
        self.btnEvaluationSheet.layer.cornerRadius = 18
        self.btnStudentResponce.layer.borderWidth = 2
        self.btnStudentResponce.layer.borderColor = UIColor.white.cgColor
        self.btnStudentResponce.layer.cornerRadius = 18
        self.StatusBarSetup()
        
    }
    
    
     ///MARK:- ButtonActions.
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapInfiBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapStudentResponce(_ sender: UIButton) {
        
    }
    
    
    @IBAction func didTapEvaluationSheet(_ sender: UIButton) {
        
    }
    
}
