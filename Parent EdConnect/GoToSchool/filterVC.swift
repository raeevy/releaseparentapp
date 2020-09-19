//
//  filterVC.swift
//  Parent EdConnect
//
//  Created by Work on 06/08/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import FSCalendar

class filterVC: UIViewController, UITableViewDataSource, UITableViewDelegate, FSCalendarDelegate {
    
    var formater = DateFormatter()
    var currentDate = Date()
    var calender:FSCalendar!
    var reason:Bool = true
    var SelectedDate:String?
    var arrSubj = ["English","Biology","Chemistry","Physics","Mathematics","Botony"]
    var nameArr = NSMutableArray()
    var nameArrayValueinString = ""
    
    @IBOutlet weak var lblSelectSubject: UILabel!
    @IBOutlet weak var lblSelectSubject2: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDate2: UILabel!
    @IBOutlet weak var dataTable: UITableView!
    @IBOutlet weak var viewSelectSubject: CustomView!
    @IBOutlet weak var viewSelectSunject2: CustomView!
    @IBOutlet weak var viewCalender: CustomView!
    @IBOutlet weak var viewCalender2: CustomView!
    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var viewAction: UIView!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var lblYearOnCalenderTop: UILabel!
    @IBOutlet weak var lblDateOnCalenderTop: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cropShadow()
        StatusBarSetup()
        viewAction.isHidden = true
        viewBackground.isHidden = true
        btnApply.isEnabled = false

        formater.dateFormat = "mm-dd-yyyy"
        formater.dateStyle = .medium
        SelectedDate = formater.string(from: currentDate)
        
        formater.setLocalizedDateFormatFromTemplate("EEE MMM d")
        lblDateOnCalenderTop.text = "\(formater.string(from: currentDate))"
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        //self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnClanderCancel(_ sender: Any) {
        viewBackground.isHidden = true
    }
    @IBAction func btnCalenderOk(_ sender: Any) {
        lblDate.text = SelectedDate
        lblDate2.text = SelectedDate
        if lblSelectSubject.text != "Select Subject" && lblDate.text != "Date" {
            btnApply.backgroundColor = #colorLiteral(red: 0.958633244, green: 0.6428905725, blue: 0.2931733727, alpha: 1)
            btnApply.isEnabled = true
        }
        viewBackground.isHidden = true
    }
    @IBAction func btnReset(_ sender: Any) {
        nameArr.removeAllObjects()
        nameArrayValueinString.removeAll()
       
        SelectedDate = nil
        btnApply.backgroundColor = #colorLiteral(red: 0.7529446483, green: 0.7527532578, blue: 0.7492577434, alpha: 1)
        btnApply.isEnabled = false

        lblSelectSubject.text = "Select Subject"
        lblDate.text = "Date"
        
        lblSelectSubject2.text = "Select Subject"
        lblDate2.text = "Date"
        
        print("lbl select subj",lblSelectSubject.text)
        print("lbl select date",lblDate.text)
        
        print("name array after reset",nameArr)
        print("name array string after reset",nameArrayValueinString)
    }
    @IBAction func btnDropDown(_ sender: Any) {
        viewAction.isHidden = false
    }
    @IBAction func btnCalender(_ sender: Any) {
        viewBackground.isHidden = false
    }
    
    //Select Subject  Date
    @IBAction func btnDropUp(_ sender: Any) {
        if lblSelectSubject.text != "Select Subject" && lblDate.text != "Date" {
            btnApply.backgroundColor = #colorLiteral(red: 0.958633244, green: 0.6428905725, blue: 0.2931733727, alpha: 1)
            btnApply.isEnabled = true
        }
        dataTable.reloadData()
        viewAction.isHidden = true
    }
    @IBAction func btnApply(_ sender: Any) {
            let storyBord = UIStoryboard(name: "GoToSchool", bundle: nil)
            let VC = storyBord.instantiateViewController(withIdentifier: "subjectAssignedVC") as! subjectAssignedVC
            self.navigationController?.pushViewController(VC, animated: false)
    }
}

//MARK:- *******-tableViewCycle()-********
//MARK:-
extension filterVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSubj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dropDownTVCell") as! dropDownTVCell
        
        cell.lblSubject.text =  arrSubj[indexPath.row]

        cell.btnCheckBox.addTarget(self, action: #selector(btnCheckBoxClicked(_:)), for: .touchUpInside)
        cell.btnCheckBox.tag = indexPath.row
        cell.btnCheckBox.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
               tableView.cellForRow(at: indexPath)?.accessoryType = .none
               
               self.nameArr.remove(arrSubj[indexPath.row])
           }
           else {
               tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
               self.nameArr.add(arrSubj[indexPath.row])
           }
        print("the subject name array", self.nameArr)
        
        self.nameArrayValueinString = nameArr.componentsJoined(by: ",")
        print("values of subject array in string", nameArrayValueinString)
        
        lblSelectSubject.text = nameArrayValueinString
        lblSelectSubject2.text = nameArrayValueinString
    }
    
    
    @objc func btnCheckBoxClicked(_ sender:UIButton){
                
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "dropDownTVCell") as! dropDownTVCell
        //
        //        reason = !reason
        //        if reason {
        //            cell.btnCheckBox.setImage(UIImage(named: "unCheck"), for: .normal)
        //        }
        //        else {
        //            cell.btnCheckBox.setImage(UIImage(named: "check"), for: .normal)
        //        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
}

extension filterVC {
    func cropShadow() {
        viewSelectSubject.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        viewSelectSubject.cornerRadius = 10
        viewSelectSubject.borderWidth = 2
        
        viewCalender.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        viewCalender.cornerRadius = 10
        viewCalender.borderWidth = 2
        
        viewSelectSunject2.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        viewSelectSunject2.cornerRadius = 10
        viewSelectSunject2.borderWidth = 2
        
        viewCalender2.borderColor = #colorLiteral(red: 0.9129725099, green: 0.9102424383, blue: 0.913417995, alpha: 1)
        viewCalender2.cornerRadius = 10
        viewCalender2.borderWidth = 2
    }
}

//MARK:- ***_calender_Delegate_***
extension filterVC {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formater.dateFormat = "mm-dd-yyyy"//(mon, may, 12)
        formater.dateStyle = .medium
        SelectedDate = formater.string(from: date)
        let calanderDate = Calendar.current.dateComponents([.day, .year, .month, .weekday], from: date)
        lblYearOnCalenderTop.text = "\(calanderDate.year!)"
        
        formater.setLocalizedDateFormatFromTemplate("EEE MMM d")
        lblDateOnCalenderTop.text = "\(formater.string(from: date))"
        
        
//        calender.appearance.todayColor = .clear
//        calendar.appearance.selectionColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        
    }
}
