//
//  quickUpdateVC.swift
//  Parent EdConnect
//
//  Created by Work on 17/06/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class quickUpdateVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewQuickUpdate: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBAction func btnClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
//
//     let VC = self.storyboard?.instantiateViewController(withIdentifier: "homeScreenVC") as! homeScreenVC
//           self.navigationController?.pushViewController(VC, animated: false)
     }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "homeScreenVC") as! homeScreenVC
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        crop()
      //  let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
               // tap.delegate = self // This is not required
               // viewBackground.addGestureRecognizer(tap)
    }
        @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
          // self.dismiss(animated: true, completion: nil)
        }
}
extension quickUpdateVC{
    func crop(){
        viewQuickUpdate.clipsToBounds = true
        viewQuickUpdate.layer.cornerRadius = 10.0
        btnSubmit.clipsToBounds = true
        btnSubmit.layer.cornerRadius = 10.0
    }
}
