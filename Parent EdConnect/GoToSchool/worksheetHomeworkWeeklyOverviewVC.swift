//
//  worksheetHomeworkWeeklyOverviewVC.swift
//  Parent EdConnect
//
//  Created by Work on 03/08/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import SDWebImage
//API:38 subject array comming from api dashboard api
class worksheetHomeworkWeeklyOverviewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var subScreenCheck:Int?
    var ServiceId:Int?
    var arrSubjectList = NSArray()
    
    @IBOutlet weak var lblScreenName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         StatusBarSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if subScreenCheck == 1 {
            lblScreenName.text = "Worksheet"
        } else if subScreenCheck == 2 {
            lblScreenName.text = "Homework"
        } else if subScreenCheck == 3 {
            lblScreenName.text = "Weekly Test Report"
        }
        print("arrSubjectList is",arrSubjectList)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
       
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK:- ******_collectionView_*****
//MARK:-
extension worksheetHomeworkWeeklyOverviewVC {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("the count is",arrSubjectList.count)
        return arrSubjectList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "overViewCVCell", for: indexPath) as! overViewCVCell
         let dict = self.arrSubjectList.object(at: indexPath.row) as? NSDictionary ?? [:]
        
        let subject_name = dict.value(forKey: "subject_name") as? String ?? ""
        let subject_icon = dict.value(forKey: "subject_icon") as? String ?? ""
        let subject_id = dict.value(forKey: "subject_id") as? String ?? ""
        print("subject_name",subject_name)
       
        cell.lblSubject.text = subject_name
        
        cell.imgSubIcon.sd_setImage(with: URL(string: subject_icon))
        cell.imgSubIcon.layer.cornerRadius = cell.imgSubIcon.frame.size.width / 2
        cell.imgSubIcon.clipsToBounds = true
        
        cell.viewInsideCell.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        cell.viewInsideCell.cornerRadius = 10
        cell.viewInsideCell.borderWidth = 2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "overViewCVCell", for: indexPath) as! overViewCVCell
        
        let dict = self.arrSubjectList.object(at: indexPath.row) as? NSDictionary ?? [:]
        let subject_name = dict.value(forKey: "subject_name") as? String ?? ""
        let subject_id = dict.value(forKey: "subject_id") as? String ?? ""

        cell.viewInsideCell.borderColor = #colorLiteral(red: 0.9523274302, green: 0.5835757852, blue: 0.2794597745, alpha: 1)
        
        if subScreenCheck == 1 {
            let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
            let VC = storyBord.instantiateViewController(withIdentifier: "subjectAssignedVC") as! subjectAssignedVC
            VC.assignVCCheck = subScreenCheck
            VC.screenName = subject_name
            VC.subId = subject_id
            VC.servIdInApi = ServiceId
            self.navigationController?.pushViewController(VC, animated: true)
        } else if subScreenCheck == 2 {
            let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
            let VC = storyBord.instantiateViewController(withIdentifier: "subjectAssignedVC") as! subjectAssignedVC
            VC.assignVCCheck = 2
            VC.screenName = subject_name
            VC.subId = subject_id
            VC.servIdInApi = ServiceId
            self.navigationController?.pushViewController(VC, animated: true)
        } else if subScreenCheck == 3 {
            let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
            let VC = storyBord.instantiateViewController(withIdentifier: "subjectAssignedVC") as! subjectAssignedVC
            VC.assignVCCheck = subScreenCheck
            VC.screenName = subject_name
            VC.subId = subject_id
            VC.servIdInApi = ServiceId
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectiomWidth = collectionView.bounds.width
        return CGSize(width: collectiomWidth/2, height: collectiomWidth/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
   
}
