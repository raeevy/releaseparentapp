//
//  AccountDetailTVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/25/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class AccountDetailTVC: UITableViewCell {
    
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var tfEmailAddress: UITextField!
    @IBOutlet weak var viewPasswordCustomHeightsConstrants: NSLayoutConstraint!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var viewRetypeCustomHeightsConstrant: NSLayoutConstraint!
    @IBOutlet weak var tfRetypePassword: UITextField!
    @IBOutlet weak var tfTypeNewPassword: UITextField!
    @IBOutlet weak var btnEyse: UIButton!
    @IBOutlet weak var btnUpdatedPassword: UIButton!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var imgpassword: UIImageView!
    @IBOutlet weak var viewPasswordLine: UIView!
    @IBOutlet weak var viewRetryPasswowd: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblTypeNewPassword: UILabel!
    @IBOutlet weak var lblTypeNewPBlue: UILabel!
    @IBOutlet weak var imgTypeNewPassword: UIImageView!
    @IBOutlet weak var viewRetypeLine: UIView!
    @IBOutlet weak var viewTypeNewPasswordLine: UIView!
    @IBOutlet weak var viewPasswowdCONTENTS: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewRetryPasswowd.isHidden = true
        self.btnCancel.isHidden = true
        self.viewPasswowdCONTENTS.isHidden = false
       // self.cancelBtnSetup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func editSetup()  {
        self.viewRetryPasswowd.isHidden = false
        self.btnCancel.isHidden = false
        self.viewPasswowdCONTENTS.isHidden = true
        self.btnEdit.isHidden = true
        
//        self.lblPassword.isHidden = true
//        self.imgpassword.isHidden = true
//        self.viewPasswordLine.isHidden = true
//        self.tfPassword.isHidden = true
//        self.btnEdit.isHidden = true
//        self.btnEdit.isUserInteractionEnabled = true
//
//        self.btnCancel.isHidden = false
//        self.lblTypeNewPBlue.isHidden = false
//        self.lblTypeNewPassword.isHidden = false
//        self.viewRetypeLine.isHidden = false
//        self.viewTypeNewPasswordLine.isHidden = false
//        self.btnEyse.isHidden = false
//        self.imgTypeNewPassword.isHidden = false
//        self.tfRetypePassword.isHidden = false
//        self.btnUpdatedPassword.isHidden = false
//        self.tfTypeNewPassword.isHidden = false
        
        self.viewPasswordCustomHeightsConstrants.constant = 0
        self.viewRetypeCustomHeightsConstrant.constant = 216
    }
    
    @IBAction func didTapEditBtn(_ sender: UIButton) {
        self.editSetup()
    }
    
    func cancelBtnSetup() {
        self.viewRetryPasswowd.isHidden = true
        self.btnCancel.isHidden = true
        self.viewPasswowdCONTENTS.isHidden = false
          self.btnEdit.isHidden = false
//        self.lblPassword.isHidden = false
//        self.imgpassword.isHidden = false
//        self.viewPasswordLine.isHidden = false
//        self.tfPassword.isHidden = false
//        self.btnEdit.isHidden = false
//        self.btnEdit.isUserInteractionEnabled = false
//
//        self.btnCancel.isHidden = true
//        self.lblTypeNewPBlue.isHidden = true
//        self.lblTypeNewPassword.isHidden = true
//        self.viewRetypeLine.isHidden = true
//        self.viewTypeNewPasswordLine.isHidden = true
//        self.btnEyse.isHidden = true
//        self.imgTypeNewPassword.isHidden = true
//        self.tfRetypePassword.isHidden = true
//        self.btnUpdatedPassword.isHidden = true
//        self.tfTypeNewPassword.isHidden = true
        
        self.viewPasswordCustomHeightsConstrants.constant = 45
        self.viewRetypeCustomHeightsConstrant.constant = 0
        print("Cancel Qamar?")
    }
    
    @IBAction func didTapCreshBtn(_ sender: UIButton) {
        self.cancelBtnSetup()
    }
    
    @IBAction func didTapEyseHideShow(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapUpdatedPasswordBtn(_ sender: UIButton) {
        
        
    }
    
    
    
}
