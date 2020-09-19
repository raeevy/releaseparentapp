//
//  ChapterWiseSubXIBMCQLevelTVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/7/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class ChapterWiseSubXIBMCQLevelTVC: UITableViewCell {

    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var lblShowScore: UILabel!
    @IBOutlet weak var lblAttempedChapterName: UILabel!
    @IBOutlet weak var progressSrore: UIProgressView!
    @IBOutlet weak var lblTestType: UILabel!
    @IBOutlet weak var imgNextArrow: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
