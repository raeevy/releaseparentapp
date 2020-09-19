//
//  ChapterXIB2TableViewCell.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/6/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class ChapterXIB2TableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var lblItemNameType: UILabel!
    @IBOutlet weak var lblShowOverallProgress: UILabel!
    @IBOutlet weak var btnDropArrow: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func didTapDDBtn(_ sender: UIButton) {
        
    }
    
    
}
