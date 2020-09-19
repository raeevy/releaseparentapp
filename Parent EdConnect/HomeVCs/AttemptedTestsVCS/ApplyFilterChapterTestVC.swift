//
//  ApplyFilterChapterTestVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/7/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class ApplyFilterChapterTestVC: UIViewController {

    @IBOutlet weak var contentsView: UIView!
    
    @IBOutlet weak var listChapterTV: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.contentsView.shadow(UIView: contentsView)
        self.contentsView.layer.cornerRadius = 10
    }
    

    @IBAction func didTapApplyFilter(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
