//
//  ViewMoreVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/10/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class ViewMoreVC: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewMoreTV: UITableView! {
        didSet {
            self.viewMoreTV.delegate = self
            self.viewMoreTV.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBarSetup()
        
      //  viewMoreTV.register(UINib(nibName: "ConceptTestTableViewCell", bundle: nil), forCellReuseIdentifier: "ConceptTestTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewMoreTV.reloadData()
    }
    
    ///Mark:-Status Bar Change
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func didTapBtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension ViewMoreVC :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.viewMoreTV.dequeueReusableHeaderFooterView(withIdentifier: "ViewMoreTableViewCell") as? ViewMoreTableViewCell else {return UITableViewCell()}
        
        cell.viewContents.shadow(UIView: cell.viewContents)
        
        return cell
    }
    
    
    
}
