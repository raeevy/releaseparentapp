//
//  PersonalJRXIBUpperTable1TVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 9/2/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class PersonalJRXIBUpperTable1TVC: UITableViewCell {
    
    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var lblTopicName: UILabel!
    @IBOutlet weak var btnDropDownArrow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      //  self.viewContents.shadow(UIView: self.viewContents)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    @IBAction func didTapBtnDDArrow(_ sender: UIButton) {
        
    }
    
}
