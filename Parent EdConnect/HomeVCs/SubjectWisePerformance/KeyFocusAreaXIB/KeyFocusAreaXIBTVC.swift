//
//  KeyFocusAreaXIBTVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/8/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class KeyFocusAreaXIBTVC: UITableViewCell {

    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var lblKeyFocusName: UILabel!
    @IBOutlet weak var lblKeySubName: UILabel!
    @IBOutlet weak var lblShowScore: UILabel!
    @IBOutlet weak var lblTargetShow: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func setupView() {
          self.viewContents.shadow(UIView: viewContents)
          
      }
}
