//
//  ProfileDetailXIBTVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/25/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class ProfileDetailXIBTVC: UITableViewCell {

    
    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var lblNameValue: UILabel!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfMobile: UITextField!
    
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var tfCountry: UITextField!
    
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var btnUpdateProfile: UIButton!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnUpdateProfile.isHidden = true
        btnEdit.isHidden = false
        tfName.isHidden = true
        tfMobile.isHidden = true
        tfEmail.isHidden = true
        
        tfCountry.isHidden = true
        lblCountry.isHidden = false
        btnCountry.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnEditProfileDetail(_ sender: Any) {
        btnUpdateProfile.isHidden = false
        btnEdit.isHidden = true
        
        tfName.isHidden = false
        tfMobile.isHidden = false
        tfEmail.isHidden = false
        
        lblName.isHidden = true
        lblEmail.isHidden = true
        lblMobile.isHidden = true
        
        tfName.text = lblName.text
        tfMobile.text = lblMobile.text
        tfEmail.text = lblEmail.text
        tfCountry.text = lblCountry.text
        
        lblCountry.isHidden = true
        tfCountry.isHidden = false
        btnCountry.isHidden = false
       
    }
    
    
    @IBAction func btnUpdateProfile(_ sender: Any) {
        btnEdit.isHidden = false
        btnUpdateProfile.isHidden = true
        tfName.isHidden = true
        tfMobile.isHidden = true
        tfEmail.isHidden = true
        
        lblName.isHidden = false
        lblEmail.isHidden = false
        lblMobile.isHidden = false
        
//        lblName.text = tfName.text
//        lblEmail.text = tfEmail.text
//        lblMobile.text = tfMobile.text
//        lblCountry.text = tfCountry.text
        
        lblCountry.isHidden = false
        tfCountry.isHidden = true
        btnCountry.isHidden = true
        
    }
     
}
