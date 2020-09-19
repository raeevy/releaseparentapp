//
//  ChapterTestTableViewCell.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/6/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class ChapterTestTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var lblHeadingName: UILabel!
    @IBOutlet weak var lblOverallProgresShow: UILabel!
    @IBOutlet weak var prograshBar: UIProgressView!
    @IBOutlet weak var btnInformation: UIButton!
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var btnMCQLavel1: UIButton!
    @IBOutlet weak var lblMCQLevel1: UILabel!
    @IBOutlet weak var btnLevel2: UIButton!
    @IBOutlet weak var lblMCQLavel2: UILabel!
    @IBOutlet weak var btnMCQL3: UIButton!
    @IBOutlet weak var lblMCQLevel3: UILabel!
    @IBOutlet weak var btnAdaptiveTest: UIButton!
    @IBOutlet weak var lblAdaptiveTest: UILabel!
    @IBOutlet weak var btnShowMore: UIButton!
    @IBOutlet weak var lblMCQLvlCheck: UILabel!
    
    @IBOutlet weak var viewHeightHide: UIView!
    @IBOutlet weak var viewCustomHeightContrants: NSLayoutConstraint!
    
    @IBOutlet weak var mcqLevelTableView: UITableView! {
        didSet {
            self.mcqLevelTableView.delegate = self
            self.mcqLevelTableView.dataSource = self
        }
    }
    
       var mcqL1DictCell = NSArray()
       var mcqL2DictCell = NSArray()
       var mcqL3DictCell = NSArray()
       var adeptiveDictCell = NSArray()
    
    ////9717864377
    ///123456
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mcqLevelTableView.register(UINib(nibName: "ChapterWiseSubXIBMCQLevelTVC", bundle: nil), forCellReuseIdentifier: "ChapterWiseSubXIBMCQLevelTVC")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

extension ChapterTestTableViewCell: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mcqL1DictCell.count >= 1 {
            return self.mcqL1DictCell.count
        }else if  mcqL2DictCell.count >= 1{
            return mcqL2DictCell.count
        } else if mcqL3DictCell.count >= 1{
            return mcqL3DictCell.count
        } else {
          return  adeptiveDictCell.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:ChapterWiseSubXIBMCQLevelTVC = tableView.dequeueReusableCell(withIdentifier: "ChapterWiseSubXIBMCQLevelTVC") as? ChapterWiseSubXIBMCQLevelTVC else { return UITableViewCell() }
        
//        let mcqL1Dict = mcqL1DictCell[indexPath.row] as? NSDictionary ?? [:]
//        let mcqL2Dict = mcqL2DictCell[indexPath.row] as? NSDictionary ?? [:]
//        let mcqL3Dict = mcqL3DictCell[indexPath.row] as? NSDictionary ?? [:]
//        let adeptiveDict = adeptiveDictCell[indexPath.row] as? NSDictionary ?? [:]
        
        
        if mcqL1DictCell.count >= 1 {
            
            let mcqL1Dict = mcqL1DictCell[indexPath.row] as? NSDictionary ?? [:]
            
            let scorePercantage = mcqL1DictCell.value(forKey: "score_percantage") as? Double ?? 0.0
            let max = 100.0
            let progressValue =  scorePercantage / 100.0
            cell.progressSrore.setProgress(Float(progressValue), animated: false)
            let valueInt = Int(scorePercantage)
            cell.lblShowScore.text = "\(valueInt)/10"
         //   cell.lblShowScore.text = "\(scorePercantage)/10"
            
            let datevalue = mcqL1Dict.value(forKey: "test_date") as? String ?? ""
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "d MMM yyyy"

            let date: NSDate? = dateFormatterGet.date(from: datevalue) as NSDate?
            cell.lblTestType.text = dateFormatterPrint.string(from: date! as Date)
            
            return cell
            
            } else if  mcqL2DictCell.count >= 1{
                let mcqL2Dict = mcqL2DictCell[indexPath.row] as? NSDictionary ?? [:]
            
            let scorePercantage = mcqL2Dict.value(forKey: "score_percantage") as? Double ?? 0.0
            let max = 100.0
            let progressValue =  scorePercantage / 100.0
            cell.progressSrore.setProgress(Float(progressValue), animated: false)
            let valueInt = Int(scorePercantage)
            cell.lblShowScore.text = "\(valueInt)/10"
          //  cell.lblShowScore.text = "\(scorePercantage)/10"
            
            let datevalue = mcqL2Dict.value(forKey: "test_date") as? String ?? ""
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "d MMM yyyy"

            let date: NSDate? = dateFormatterGet.date(from: datevalue) as NSDate?
            cell.lblTestType.text = dateFormatterPrint.string(from: date! as Date)
            
            
            return cell
            } else if mcqL3DictCell.count >= 1{
            
            let mcqL3Dict = mcqL3DictCell[indexPath.row] as? NSDictionary ?? [:]
            let scorePercantage = mcqL3Dict.value(forKey: "score_percantage") as? Double ?? 0.0
            let max = 100.0
            let progressValue =  scorePercantage / 100.0
            cell.progressSrore.setProgress(Float(progressValue), animated: false)
            let valueInt = Int(scorePercantage)
            cell.lblShowScore.text = "\(valueInt)/10"
           // cell.lblShowScore.text = "\(scorePercantage)/10"
            
            let datevalue = mcqL3Dict.value(forKey: "test_date") as? String ?? ""
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "d MMM yyyy"

            let date: NSDate? = dateFormatterGet.date(from: datevalue) as NSDate?
            cell.lblTestType.text = dateFormatterPrint.string(from: date! as Date)
            
            
            return cell
        } else if adeptiveDictCell.count >= 1{
              let adeptiveDict = adeptiveDictCell[indexPath.row] as? NSDictionary ?? [:]
            
                      let scorePercantage = adeptiveDict.value(forKey: "score_percantage") as? Double ?? 0.0
                      let max = 100.0
                      let progressValue =  scorePercantage / 100.0
                      cell.progressSrore.setProgress(Float(progressValue), animated: false)
            
                     let valueInt = Int(scorePercantage)
                      cell.lblShowScore.text = "\(valueInt)/10"
                      
                      let datevalue = adeptiveDict.value(forKey: "test_date") as? String ?? ""
                      let dateFormatterGet = DateFormatter()
                      dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

                      let dateFormatterPrint = DateFormatter()
                      dateFormatterPrint.dateFormat = "d MMM yyyy"

                      let date: NSDate? = dateFormatterGet.date(from: datevalue) as NSDate?
                      cell.lblTestType.text = dateFormatterPrint.string(from: date! as Date)
            
            return cell
        } else {
            
            return UITableViewCell()
        }
  }
        
}
