//
//  evaluatedWorksheetVC.swift
//  Parent EdConnect
//
//  Created by Work on 14/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class evaluatedWorksheetVC: UIViewController {
    
    
    @IBOutlet weak var viewYourScore: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         viewYourScore.gradientPurple()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
