//
//  TestWiseAnlysisTVCXib.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 9/1/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class TestWiseAnlysisTVCXib: UITableViewCell {
    
    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var tableViewCustomHeightsConstrants: NSLayoutConstraint!
    @IBOutlet weak var xibTableView: UITableView!{
        didSet {
            self.xibTableView.dataSource = self
            self.xibTableView.delegate = self
        }
    }
    
    let i = 67
    let max = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.xibTableView.register(UINib(nibName: "TestWiseAnlysisXIB2", bundle: nil), forCellReuseIdentifier: "TestWiseAnlysisXIB2")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}

extension TestWiseAnlysisTVCXib :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell:TestWiseAnlysisXIB2 = xibTableView.dequeueReusableCell(withIdentifier: "TestWiseAnlysisXIB2") as? TestWiseAnlysisXIB2  else {  return UITableViewCell() }
        
        
        let ratio = Float(i) / Float(max)
        let ratio1 = Float(ratio) / Float(max)
        
        cell.progressBar.setProgress(ratio1, animated: false)
        cell.progressBar.transform =  cell.progressBar.transform.scaledBy(x: 1, y: 2)
        
        return cell
    }
}
