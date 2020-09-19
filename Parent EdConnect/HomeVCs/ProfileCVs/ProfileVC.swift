//
//  ProfileVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/25/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire

class ProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    var imagePicker = UIImagePickerController()
    var arrResponse = NSArray()
    
    
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    let arrayUserDef =  UserDefaults.standard.array(forKey: "ARRCHILD")
    
    var parentEmail = UserDefaults.standard.value(forKey: "PEMAIL")
    var parentName = UserDefaults.standard.value(forKey: "NAME")
    var parentMobile = UserDefaults.standard.value(forKey: "PMOBILE")
    var countryCode = UserDefaults.standard.value(forKey: "COUNTRYCODE")

    
    
    var Code:String?
    var mobileNo:String?
    var email:String?
    var name:String?
   
    


    
    var userIs = UserDefaults.standard.value(forKey: "USERNAME")
    var paasWord = UserDefaults.standard.value(forKey: "PASSWORD")


    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var countryTable: UITableView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var btnCamra: UIButton!
    @IBOutlet weak var lblClassName: UILabel!
    @IBOutlet weak var btnThreeDot: UIButton!
    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var btnChildDetails: UIButton!
    @IBOutlet weak var btnProfileDetail: UIButton!
    @IBOutlet weak var btnAccountDetails: UIButton!
    @IBOutlet weak var listTableView: UITableView! {
        didSet {
            self.listTableView.dataSource = self
            self.listTableView.delegate = self
        }
    }
    
    var childDetail: String?

    public var currentSelectedIndexChildD = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StatusBarSetup()
        listTableView.register(UINib.init(nibName: "ProfileXIBTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileXIBTableViewCell")
        listTableView.register(UINib.init(nibName: "ProfileDetailXIBTVC", bundle: nil), forCellReuseIdentifier: "ProfileDetailXIBTVC")
        listTableView.register(UINib.init(nibName: "AccountDetailTVC", bundle: nil), forCellReuseIdentifier: "AccountDetailTVC")
        
        self.viewContents.shadow(UIView: viewContents)
        
        //croping profileimage in circlular shape
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width / 2
        imageProfile.clipsToBounds = true
        
        viewBackground.isHidden = true
        countryTable.isHidden  = true
        
        print("my countryCode is",countryCode)
        API49()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if currentSelectedIndexChildD == 0 {
            self.didTapChildDetailBtn(UIButton())
        } else if currentSelectedIndexChildD == 1{
            self.didTapProfileDetailBtn(UIButton())
        } else {
            self.didTapAccountBtn(UIButton())
        }

    }
    ///Mark:-Status Bar Change
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARL FOR Select Actions.
    func currentSection(type: String) {
        if type == "1" {
            childDetail = "Child Detail"
            
        } else if type == "2" {
            childDetail = "Profile Detail"
            
        } else {
            childDetail = "Account Detail"
        }
    }

    //MARK:- ButtonsActions.
    
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func didTapThreeDot(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapDropDownBtn(_ sender: UIButton) {
                
        let storyBord = UIStoryboard(name: "Home", bundle: nil)
        let VC = storyBord.instantiateViewController(withIdentifier: "RateUsVC") as! RateUsVC
        self.navigationController?.present(VC, animated: true, completion: nil)
    }
    
    @IBAction func didTapCameraBtn(_ sender: UIButton) {
        ///Foe Test Screens .
        
        pickImage()

    }
    
    @IBAction func didTapChildDetailBtn(_ sender: UIButton) {
        var myColor = UIColor(red:225.0/225.0, green:179.0/225.0, blue:16.0/225.0, alpha:1.0)
        self.btnChildDetails.setTitleColor(myColor, for: .normal)
        self.btnProfileDetail.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnAccountDetails.setTitleColor(UIColor.lightGray, for: .normal)
        self.currentSection(type: "1")
        self.listTableView.reloadData()
    }
    
    @IBAction func didTapProfileDetailBtn(_ sender: UIButton) {
        self.btnChildDetails.setTitleColor(UIColor.lightGray, for: .normal)
        var myColor = UIColor(red:225.0/225.0, green:179.0/225.0, blue:16.0/225.0, alpha:1.0)
        self.btnProfileDetail.setTitleColor(myColor, for: .normal)
        self.btnAccountDetails.setTitleColor(UIColor.lightGray, for: .normal)
        self.currentSection(type: "2")
        self.listTableView.reloadData()
    }
    
    
    @IBAction func didTapAccountBtn(_ sender: UIButton) {
        self.btnChildDetails.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnProfileDetail.setTitleColor(UIColor.lightGray, for: .normal)
        var myColor = UIColor(red:225.0/225.0, green:179.0/225.0, blue:16.0/225.0, alpha:1.0)
        self.btnAccountDetails.setTitleColor(myColor, for: .normal)
        self.currentSection(type: "3")
        self.listTableView.reloadData()
    }

}

//MARK:- ********_tableView_Cycle_******
//MARK:
extension ProfileVC:UITableViewDataSource, UITableViewDelegate {

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == countryTable {
            return arrResponse.count
        }
        else {
            if childDetail == "Child Detail"{
                
                print("arrayUserDef?.count is",arrayUserDef?.count)
                return arrayUserDef?.count ?? 0
            } else if childDetail == "Profile Detail"{
                return 1
            }else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == countryTable {
            return 44
            
        } else {
            if childDetail == "Child Detail"{
                return 174
            } else if childDetail == "Profile Detail"{
                return 269
            }else {
                return 400
            }
        }
    }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellToReturn = UITableViewCell() // Dummy value

        if  tableView == countryTable {
            
//            let cell = countryTable.dequeueReusableCell(withIdentifier: "countryTVCell") as! countryTVCell
            
             let cell = countryTable.dequeueReusableCell(withIdentifier: "countryTVCell") as! countryTVCell
            let dict = arrResponse[indexPath.row] as? NSDictionary ?? [:]
            
            let country = dict.value(forKey: "title") as? String ?? ""
            let flag = dict.value(forKey: "flag") as? String ?? ""
            let phoneCode = dict.value(forKey: "phone_code") as? Int ?? 0
            
            print("flag is",flag)
            print("country is",country)
            
            cell.imgFlag.sd_setImage(with: URL(string: flag))
            
            cell.lblCountryName.text = "\(country )(\(phoneCode))"
            cellToReturn = cell
        }
        else {
            
            if childDetail == "Child Detail"{
                guard let cell:ProfileXIBTableViewCell = listTableView.dequeueReusableCell(withIdentifier: "ProfileXIBTableViewCell") as? ProfileXIBTableViewCell else {  return UITableViewCell() }
                
                let dict = self.arrayUserDef?[indexPath.row] as? NSDictionary ?? [:]
                
                
                let childName = dict.value(forKey: "child_name") as? String ?? ""
                let email = dict.value(forKey: "email") as? String ?? ""
                cell.lblChildValue.text = "Child \(indexPath.row + 1)"
                cell.lblUserName.text = childName
                cell.lblEmailAddress.text = email
                
                cellToReturn = cell
            } else if childDetail == "Profile Detail"{
               guard let cell:ProfileDetailXIBTVC = listTableView.dequeueReusableCell(withIdentifier: "ProfileDetailXIBTVC") as? ProfileDetailXIBTVC else {  return UITableViewCell() }
                
                cell.btnEdit.layer.cornerRadius = cell.btnEdit.frame.size.width / 2
                cell.btnEdit.clipsToBounds = true
                
                cell.btnUpdateProfile.layer.cornerRadius = cell.btnUpdateProfile.frame.size.width / 2
                cell.btnUpdateProfile.clipsToBounds = true
                
                cell.tfName.text = cell.lblName.text
                cell.tfEmail.text = cell.lblEmail.text
                cell.tfMobile.text = cell.lblMobile.text
                
                if parentName != nil {
                    cell.lblName.text = "\(parentName!)"
                }
                else {
                   cell.lblName.text = "No Name found"
                }
                
                if parentEmail != nil {
                       cell.lblEmail.text = "\(parentEmail!)"
                }
                else {
                   cell.lblEmail.text = "No Email found"
                }
                if parentMobile != nil {
                    cell.lblMobile.text = "\(parentMobile!)"
                }
                else {
                    cell.lblMobile.text = "No Number Found"
                }
                
                cell.btnCountry.addTarget(self, action: #selector(btnCountryClicked(_:)), for: .touchUpInside)
                
                cell.btnCountry.tag = indexPath.row

                cell.btnUpdateProfile.addTarget(self, action: #selector(btnUpdateProfileClicked(_:)), for: .touchUpInside)
                cell.btnUpdateProfile.tag = indexPath.row
               
                
                ()
                
                cellToReturn = cell
            }else {
                
                guard let cell:AccountDetailTVC = listTableView.dequeueReusableCell(withIdentifier: "AccountDetailTVC") as? AccountDetailTVC else {  return UITableViewCell() }
                cell.btnUpdatedPassword.btnGradientCrop(UIButton: cell.btnUpdatedPassword)
                cell.btnUpdatedPassword.layer.cornerRadius = 10
                
                cell.tfEmailAddress.text = "\(userIs!)"
                cell.tfPassword.text = "\(paasWord!)"
                
               cellToReturn = cell
            }
            
        }
         return cellToReturn
        
    }
    
    @objc func btnCountryClicked(_ sender:UIButton){
        viewBackground.isHidden = false
        countryTable.isHidden = false
        
    }
    @objc func btnUpdateProfileClicked(_ sender:UIButton){
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "homeScreenVC") as! homeScreenVC
        self.navigationController?.pushViewController(VC, animated: false)
        
//    api47()
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == countryTable {
            
            let cell = countryTable.dequeueReusableCell(withIdentifier: "countryTVCell") as! countryTVCell

            let cell2 = listTableView.dequeueReusableCell(withIdentifier: "ProfileDetailXIBTVC") as! ProfileDetailXIBTVC
            
            let dict = arrResponse[indexPath.row] as? NSDictionary ?? [:]
            var phoneCode2 = dict.value(forKey: "phone_code") as? Any ?? ""
            
            countryTable.isHidden = true
            viewBackground.isHidden = true
            
            print("phoneCode2 is",phoneCode2)
            
            
            cell2.tfMobile.text = "\(phoneCode2)"
            cell2.tfCountry.text = "\(phoneCode2)"
            
        }
        else {
            
        }
    }
}


//MARK:- ******_func_image_upload_****
//MARK:-

extension ProfileVC {
    //-function to pick image
    func pickImage() {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        //        self.present(alert, animated: true, completion: nil)
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    //-function to open camera
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //-function to open gallery
    func openGallary()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have perission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK:-- ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            imageProfile.image = pickedImage
            
        }
        else {
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK:- *********_api47_updae_profile_************
//MARK:-
extension ProfileVC {

        func api47() {
            
            let action = "parent_profile"
            
            // userId :name:phoneCode:phonenumber :API_key:Salt
            
            let checkSum =  "\(UserId!):\(parentName!):\(countryCode!):\(parentMobile!):\(apikeyMain):\(saltMain)"
            
            print("ist chcesum string",checkSum)
            
//            if name != nil && Code != nil && mobileNo != nil {
//                var checkSum =  "\(UserId!):\(name!):\(Code!):\(mobileNo!):\(apikeyMain):\(saltMain)"
//            }
//            else if name = nil && Code = nil && mobileNo = nil {
//                var checkSum =  "\(UserId!):\(name):\(Code):\(mobileNo):\(apikeyMain):\(saltMain)"
//            } else if name = nil && Code != nil && mobileNo != nil {
//                var checkSum =  "\(UserId!):\(name):\(Code!):\(mobileNo!):\(apikeyMain):\(saltMain)"
//            } else if name != nil && Code = nil && mobileNo != nil {
//                var checkSum =  "\(UserId!):\(name!):\(Code):\(mobileNo!):\(apikeyMain):\(saltMain)"
//            } else if name = nil && Code = nil && mobileNo != nil {
//                var checkSum =  "\(UserId!):\(name):\(Code):\(mobileNo!):\(apikeyMain):\(saltMain)"
//            }
            
           // var uparcaseChecksum = checkSum.uppercased()

            
            var myChecksum = MD5(checkSum)
   

            var dicUserinfo = NSMutableDictionary()
            dicUserinfo.addEntries(from: ["email":parentEmail, "phonenumber":parentMobile, "phonecode":countryCode, "name":parentName, "user_id":UserId])

            
            

            var dicApiDetails = NSMutableDictionary()
            dicApiDetails.addEntries(from: ["apikey":apikeyMain,"checksum":myChecksum])
                    
            let postData = [
                "action": action,
                "userinfo":dicUserinfo,
                "api_details":dicApiDetails
                ] as [String : Any]
            
            print("the data is API", postData)
            print("dicUserinfo is",dicUserinfo)
            print("dicApiDetails is",dicApiDetails)
            print("the chceksum String", checkSum)
            print("converted chceksum value ", myChecksum)
            
            if Reachability.isConnectedToNetwork() {
                showActivityIndicator()
                AF.request("\(baseUrl)v1.1/profileupdate", method: .post, parameters: postData, encoding: JSONEncoding.default )
                                        
                       .responseJSON { (response) in
                        switch response.result {
                        case .success:
                            if let JSON = response.value as? [String: Any]  {
                                
                                self.hideActivityIndicator()
                                print("THE JSON RESULT 47",JSON)
                                
                                let Status = JSON["status"] as? Int ?? 0
                                let title = JSON["title"] as? Int ?? 0
                                let detail = JSON["detail"] as? Int ?? 0
                                
//                                print("status 47 is ",Status)
//                                print("title 47 is ",title)
//                                print("Status 47 is ",detail)
//
                                
                                if Status == 1 {
                                    self.hideActivityIndicator()
                                    print("Status is",Status)
                                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "homeScreenVC") as! homeScreenVC
                                    self.navigationController?.pushViewController(VC, animated: false)
                                }
                                else {
                                    "message"
                                    var Message = JSON["message"] as? String ?? ""
                                    
                                    self.alert(message: Message)
                                }
                               
                                
                            }
                        case .failure(let error):
                            
                            self.hideActivityIndicator()
                            print("ERROR", error.localizedDescription)
                            self.alert(message: error.localizedDescription)

                            
                        }
                }
            }
            else {
                self.hideActivityIndicator()
                alert(message: "No Internet Connection!!")
        }
    }
}

//MARK:- *********_get_country_list_************
//MARK:-
extension ProfileVC {
    
      func API49() {
        
        
            if Reachability.isConnectedToNetwork() {
                showActivityIndicator()
                AF.request("http://emstage.extramarks.com/api/v1.0/countrylist?apikey=0DEAD50C6BBA59FF22D33C994&checksum=b4c148f90fc287963e5aacccbbfd4a38")
                    
                    .responseJSON { (response) in
                        switch response.result {
                        case .success:
                            if let JSON = response.value as? [String: Any]  {
                                self.hideActivityIndicator()
                                print("THE JSON RESULT 49",JSON)
                                let Status = JSON["response_code"] as? Int ?? 0
                                print("the status is",Status)
                                let message = JSON["message"] as? String ?? ""
                                print("the message is ",message)
                                
                                if message == "success" {
                                    
                                    self.arrResponse = JSON["content"] as? NSArray ?? []
                                    
                               
                                    print("arrResponse is",self.arrResponse)

                                    self.countryTable.reloadData()
                                    
                                }
                            }
                        case .failure(let error):
                            self.hideActivityIndicator()
                            print("ERROR", error.localizedDescription)
                            self.alert(message: error.localizedDescription)
                    }
                }
            }
            else {
                self.hideActivityIndicator()
                alert(message: "No Internet Connection!!")
        }
    }
}


//MARK:- *********_API_Update_Password_************
//MARK:-
extension ProfileVC {
            func api48() {

                var action = "change_password"
                var appName =  "Parent EdConnect"
                
              let deviceId = UIDevice.current.identifierForVendor?.uuidString
                print("the device id is \(deviceId)")

                let Device = UIDevice.current
                let iosVersion = NSString(string: Device.systemVersion).doubleValue

               //action :app_tag_name:userId:oldPassword:newPassword :API_key:Salt

                var checkSum =  "\(action):\(appName):\(UserId!):\("oldPassword"):\("newPassword"):\(apikeyMain):\(saltMain)"
                
                var uparcaseChecksum = checkSum.uppercased()
                var myChecksum = MD5(uparcaseChecksum)

                var dicChangePwdDetails = NSMutableDictionary()
                dicChangePwdDetails.addEntries(from: ["newpwd":"", "oldpwd":"", "user_id":UserId])

                var dicApiDetails = NSMutableDictionary()
                dicApiDetails.addEntries(from: ["apikey":apikeyMain,"checksum":myChecksum])
                
                let postData = [
                      "action": "change_password",
                      "api_details": dicApiDetails,
                      "app_name": "appName",
                      "app_version": "1.0",
                      "change_pwd_details": dicChangePwdDetails,
                      "device_id":deviceId,
                      "operating_system_version": iosVersion,
                      "source": "ios"
                    ] as [String : Any]

                print("the data is API", postData)
                print("dicUserinfo is",dicApiDetails)
                print("dicApiDetails is",dicApiDetails)
                print("the chceksum String", checkSum)
                print("uparcaseChecksum is",uparcaseChecksum)
                print("converted chceksum value ", myChecksum)

                if Reachability.isConnectedToNetwork() {
                    showActivityIndicator()
                    AF.request("\(baseUrl)v1.3/tabletregistration", method: .post, parameters: postData, encoding: JSONEncoding.default )


//                        http://emstage.extramarks.com/api/v1.3/tabletregistration

                        
                             .responseJSON { (response) in
                            switch response.result {
                            case .success:
                                if let JSON = response.value as? [String: Any]  {

                                    self.hideActivityIndicator()
                                    print("THE JSON RESULT 47",JSON)

                                    let Status = JSON["status"] as? Int ?? 0
                                    let title = JSON["title"] as? Int ?? 0
                                    let detail = JSON["detail"] as? Int ?? 0

    //                                print("status 47 is ",Status)
    //                                print("title 47 is ",title)
    //                                print("Status 47 is ",detail)
    //
                                    if Status == 9012 {
                                        self.hideActivityIndicator()
                                        print("Status is",Status)
                                        let VC = self.storyboard?.instantiateViewController(withIdentifier: "homeScreenVC") as! homeScreenVC
                                        self.navigationController?.pushViewController(VC, animated: false)
                                    }
                                    else {
                                        "message"
                                        var Message = JSON["message"] as? String ?? ""
                                        self.alert(message: Message)
                                    }
                                }
                            case .failure(let error):
                                self.hideActivityIndicator()
                                print("ERROR", error.localizedDescription)
                                self.alert(message: error.localizedDescription)
                            }
                    }
                }
                else {
                    self.hideActivityIndicator()
                    alert(message: "No Internet Connection!!")
            }
        }
    
}
