//
//  ConceptTestTableViewCell.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/6/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class ConceptTestTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContents: CustomView!
    @IBOutlet weak var lblShowScore: UILabel!
    @IBOutlet weak var lblAttempedChapterName: UILabel!
    @IBOutlet weak var progressSrore: UIProgressView!
    @IBOutlet weak var lblTestType: UILabel!
    @IBOutlet weak var imgNextArrow: UIImageView!
    @IBOutlet weak var lblChaptersValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
