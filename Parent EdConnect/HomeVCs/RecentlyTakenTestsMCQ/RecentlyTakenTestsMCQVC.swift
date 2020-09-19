//
//  RecentlyTakenTestsMCQVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/6/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class RecentlyTakenTestsMCQVC: UIViewController {

    @IBOutlet weak var viewAccuracy: UIView!
    @IBOutlet weak var viewEvaluation: UIView!
    @IBOutlet weak var viewOverview: UIView!
    @IBOutlet weak var viewCircularTop: UIView!
    @IBOutlet weak var btnAnswerKey: UIButton!
    @IBOutlet weak var viewBarChart: UIView!
    @IBOutlet weak var loader1: CircularView!
    @IBOutlet weak var loader2: CircularView!
    
    @IBAction func tapAnswerKey(_ sender: Any) {
        let storyBord = UIStoryboard(name: "Home", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "MCQScoreDetailVC") as! MCQScoreDetailVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        helperFunctions()
        
        loader1.Start(value: 20, color: orangeColor)
        loader2.Start(value: 30, color: orangeColor)
    }
}

extension RecentlyTakenTestsMCQVC{
    func helperFunctions() {
        viewCircularTop.graphLoader(UIView: viewCircularTop)
        btnAnswerKey.btnGradientCrop(UIButton: btnAnswerKey)
        viewOverview.shadow(UIView: viewOverview)
        viewEvaluation.gradientBlueWithCornerRadius()
        viewAccuracy.gradientBlueWithCornerRadius()
        viewBarChart.shadow(UIView: viewBarChart)
        
    }
    
}
