//
//  stepsToAddChlidVC.swift
//  Parent EdConnect
//
//  Created by Work on 12/06/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class stepsToAddChlidVC: UIViewController {

    @IBOutlet weak var btnAddChild: UIButton!
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddChlidAction(_ sender: Any) {
       let VC = self.storyboard?.instantiateViewController(withIdentifier: "QRScannerVC") as! QRScannerVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBarSetup()
        cropShadow()
        
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
             return .lightContent
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


extension stepsToAddChlidVC {
    func cropShadow() {
        
    btnAddChild.layer.borderColor = #colorLiteral(red: 0.9723195434, green: 0.7530776262, blue: 0.3175763786, alpha: 1)
    btnAddChild.layer.borderWidth = 1.5
    btnAddChild.layer.cornerRadius = 18.0
    btnAddChild.layer.masksToBounds = true;
        
    }
}
