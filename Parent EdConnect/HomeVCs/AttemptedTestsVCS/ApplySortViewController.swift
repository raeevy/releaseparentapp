//
//  ApplySortViewController.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/7/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class ApplySortViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var btnApplySort: UIButton!
    @IBOutlet weak var btnNewest: UIButton!
    @IBOutlet weak var btnOldest: UIButton!
    @IBOutlet weak var btnHighSrore: UIButton!
    @IBOutlet weak var btnLowSrore: UIButton!
    @IBOutlet weak var lblNewest: UILabel!
    @IBOutlet weak var lblOldest: UILabel!
    @IBOutlet weak var lblHighSrore: UILabel!
    @IBOutlet weak var lblLowSrore: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.contentView.layer.cornerRadius = 10
    }
    
    @IBAction func didTapApplySort(_ sender: UIButton) {
      //  self.navigationController?.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
 

}
