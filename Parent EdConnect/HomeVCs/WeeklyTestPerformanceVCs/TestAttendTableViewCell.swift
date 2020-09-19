//
//  TestAttendTableViewCell.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/20/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class TestAttendTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var imgSubject: UIImageView!
    @IBOutlet weak var lblNameSubject: UILabel!
    @IBOutlet weak var lblAttemptValue: UILabel!
    @IBOutlet weak var progressBarSubject: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
