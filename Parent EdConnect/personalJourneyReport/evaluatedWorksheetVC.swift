//
//  evaluatedWorksheetVC.swift
//  Parent EdConnect
//
//  Created by Work on 14/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class evaluatedWorksheetVC: UIViewController {
    
    var score:String?
    var userLevel:String?
    var UserMessage: String?
    var thechildName = UserDefaults.standard.value(forKey: "CHILDNAME")
    
    @IBOutlet weak var viewYourScore: UIView!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewYourScore.gradientPurple()
        print("score",score)
        print("UserMessage",UserMessage)
        self.StatusBarSetup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if score != nil {
            lblScore.text = score
        }
        if UserMessage != nil {
            lblMessage.text = "\(thechildName!) \(UserMessage!)"
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)        
    }
}
