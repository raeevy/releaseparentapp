//
//  ProfileXIBTableViewCell.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/25/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class ProfileXIBTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var lblChildValue: UILabel!
    
  
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblEmailAddress: UILabel!
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
