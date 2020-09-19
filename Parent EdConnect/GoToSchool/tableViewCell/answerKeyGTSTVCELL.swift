//
//  answerKeyGTSTVCELL.swift
//  Parent EdConnect
//
//  Created by Work on 11/08/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class answerKeyGTSTVCELL: UITableViewCell {
    
    
    @IBOutlet weak var lblExpalnation: UILabel!
    
    @IBOutlet weak var lblQuesNumber: UILabel!
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var lblRightAns: UILabel!
    
    @IBOutlet weak var lblWrongAns: UILabel!
    @IBOutlet weak var viewInsideCell: CustomView!
    
    @IBOutlet weak var btnAnsStatus: UIButton!
    
    
    @IBOutlet weak var webView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
