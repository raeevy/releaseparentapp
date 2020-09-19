//
//  childDetailVC.swift
//  Parent EdConnect
//
//  Created by Work on 24/06/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class childDetailVC: UIViewController {
    
    var name:String?
    var email:String?
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    @IBAction func btnContinueAction(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "homeScreenVC") as! homeScreenVC
        self.navigationController?.pushViewController(VC, animated: false)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBarSetup()
        lblName.text = name
        lblEmail.text = email
       cropNdShadow()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
             return .lightContent
       }
       
}
extension childDetailVC {
    func cropNdShadow() {
        btnContinue.layer.cornerRadius = 18.0
        btnContinue.layer.masksToBounds = true;
    }
}
