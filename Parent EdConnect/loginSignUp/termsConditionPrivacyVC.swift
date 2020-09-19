//
//  termsConditionPrivacyVC.swift
//  Parent EdConnect
//
//  Created by Work on 22/06/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import WebKit

class termsConditionPrivacyVC: UIViewController {
    
    var urlToShow:String?
     
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var lblScreenName: UILabel!
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBarSetup()
        
        if urlToShow == "termsCondition" {
            lblScreenName.text = "Terms & Conditions"
            let path = Bundle.main.path(forResource: "ess_terms_and_condition", ofType: "pdf")
                   let url = URL(fileURLWithPath: path!)
                   let request = URLRequest(url: url)
                   webView.load(request)
        }
        
        if urlToShow == "privacyPolicy" {
             lblScreenName.text = "Privacy Policy"
            let path = Bundle.main.path(forResource: "ess_privacypolicy", ofType: "pdf")
            let url = URL(fileURLWithPath: path!)
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
             return .lightContent
       }
       
}
