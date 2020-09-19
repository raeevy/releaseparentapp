//
//  loginVC.swift
//  Parent EdConnect
//
//  Created by Work on 10/06/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//
import UIKit
import Alamofire

class loginVC: UIViewController {
    var deviceId:String?
    var iconClick = true
    var responseArray = NSArray()
    
    @IBOutlet weak var imgAlex: UIImageView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    
    //Mark:- ********__viewCycle_viewDidload_********
    //Mark:-
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StatusBarSetup()
        gradiantCrop()
        //testiOSd
        //test1
        
//        rama12345/123456- for parent app
        txtUserName.text = "rama12345"
        txtPassword.text = "1234567"
        
    }
    ///For Status bar Color Cahnge.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnSecurePassword(_ sender: Any) {
        
        if(iconClick == true) {
            txtPassword.isSecureTextEntry = false
        } else {
        }
        txtPassword.isSecureTextEntry = true
        iconClick = !iconClick
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        validationsTextFields()
    }
    
    @IBAction func btnSignupAction(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

extension loginVC {
    func gradiantCrop() {
        btnLogin.applyGradient(colours: [UIColor(red: 247.0/255.0, green: 149.0/255.0, blue: 72.0/255.0, alpha: 1.0), UIColor(red: 255.0/255.0, green: 196.0/255.0, blue: 83.0/255.0, alpha: 1.0)])
        btnLogin.clipsToBounds = true
        btnLogin.layer.cornerRadius = 10.0
        viewLogin.clipsToBounds = true
        viewLogin.layer.cornerRadius = 10.0
        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "Alex_login", withExtension: "gif")!)
        imgAlex.image = UIImage.gifImageWithData(imageData!)
    }
}


extension loginVC {
    func validationsTextFields() {
        if (txtUserName.text?.isEmpty == true) &&
            (txtPassword.text?.isEmpty == true) {
            alert(message: "Please fill the details!")
        }
        else if (txtUserName.text?.isEmpty == true) {
            alert(message: "Please enter the User Name!")
        }
        else if (txtPassword.text?.isEmpty == true) {
            alert(message: "Please enter the Password!")
        }
        else {
            loginApi()
//
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
//            let VC = storyBoard.instantiateViewController(withIdentifier: "NewFeatureVC") as! NewFeatureVC
//            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}

//MARK:-:*****_login_api_********
//
extension loginVC {
    
    func loginApi() {
        
        
        var action = "login"
   
        deviceId = UIDevice.current.identifierForVendor?.uuidString
        print("the device id is \(deviceId)")
        
        let Device = UIDevice.current
        let iosVersion = NSString(string: Device.systemVersion).doubleValue
        print("the ios version is",iosVersion)
        
        var logindetailsDataDict = NSMutableDictionary()
        logindetailsDataDict.addEntries(from: ["app_name":"Parent App", "device_id":deviceId!,"email_address": txtUserName.text!, "is_new_app":"1", "operating_system_version":iosVersion, "password": txtPassword.text!, "source":"ios"]  )
        
        var checkSum =  "\(action):\(txtUserName.text!):\(txtPassword.text!):::::\(apikeyMain):\(saltMain)"
        
        let myChecksum = MD5(checkSum)

        var apiDetailDataDict = NSMutableDictionary()
        apiDetailDataDict.addEntries(from: ["apikey":apikeyMain,"checksum":myChecksum!])
        
        let postData = [
            "action":action,
            "api_details":apiDetailDataDict,
            "login_details":logindetailsDataDict
            ] as [String : Any]
        
        print("the data is API", postData)
        print("apiDetailDataDict is",apiDetailDataDict)
        print("logindetailsDataDict is",logindetailsDataDict)
        print("the chceksum String", checkSum)
        print("converted chceksum value ", myChecksum!)
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            // APILoader.show()
            AF.request("http://emstage.extramarks.com/api/v1.4/tabletregistration", method: .post, parameters: postData, encoding: JSONEncoding.default )
                
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                           // APILoader.hide()
                            print("THE JSON RESULT LOGIN",JSON)
                            let Status = JSON["response_code"] as? Int ?? 0
                            print(Status)
                            if Status == 4003 {                                       self.hideActivityIndicator()
//                                APILoader.hide()
                                print("Status is",Status)
                                let dictContent = JSON["content"] as? NSDictionary ?? [:]
                                let displayName = dictContent.value(forKey: "display_name") as? Any ?? ""
                                let email = dictContent.value(forKey: "email") as? Any ?? ""
                                let mobile = dictContent.value(forKey: "mobile") as? Any ?? ""
                                let countyCode = dictContent.value(forKey: "county_code") as? Any ?? ""
                                
                                print("countyCode is",countyCode)
                                
                                
                                UserDefaults.standard.set(displayName, forKey: "NAME")
                                UserDefaults.standard.set(email, forKey: "PEMAIL")
                                UserDefaults.standard.set(mobile, forKey: "PMOBILE")
                                UserDefaults.standard.set(countyCode, forKey: "COUNTRYCODE")
                                
                                

                                
                                let parentId = dictContent.value(forKey: "user_id") as? Any ?? ""
                                
                                UserDefaults.standard.set(parentId, forKey: "PARENTID")
                                let arrChildDetail = JSON["child_details"] as? NSArray ?? []
                                if arrChildDetail.count != 0 {
                                    let arrChildInfo = arrChildDetail.object(at: 0) as? NSDictionary ?? [:]
                                    let childName = arrChildInfo.value(forKey: "child_name") as?
                                        String ?? ""
                                    let childUserId = arrChildInfo.value(forKey: "child_user_id") as? String ?? ""
                                    let Class = arrChildInfo.value(forKey: "class") as? Any ?? ""
                                    let lastActive = arrChildInfo.value(forKey: "last_active_on") as? Any ?? ""
                                    let boardId = arrChildInfo.value(forKey: "board_id") as? Any ?? ""
                                    let classId = arrChildInfo.value(forKey: "class_id") as? Any ?? ""
                                    let email = arrChildInfo.value(forKey: "email") as? Any ?? ""
                                    let mobile = arrChildInfo.value(forKey: "child_mobile_number") as? Any ?? ""
                                    let profilePic = arrChildInfo.value(forKey: "profile_pic") as? String ?? ""
                                    
                                    UserDefaults.standard.set(childUserId, forKey: "USERID")
                                    UserDefaults.standard.set(classId, forKey: "CLASSID")
                                    UserDefaults.standard.set(boardId, forKey: "BOARDID")
                                    UserDefaults.standard.set(email, forKey: "EMAIL")
                                    UserDefaults.standard.set(mobile, forKey: "MOBILE")
                                    UserDefaults.standard.set(childName, forKey: "CHILDNAME")
                                    UserDefaults.standard.set(childUserId, forKey: "CHILDID")
                                    UserDefaults.standard.set(Class, forKey: "CLASS")
                                    UserDefaults.standard.set(lastActive, forKey: "LASTACTIVE")
                                    UserDefaults.standard.set(arrChildDetail, forKey: "ARRCHILD")
                                     UserDefaults.standard.set(profilePic, forKey: "PROFILEPIC")

                                    var username = self.txtUserName.text
                                    var password = self.txtPassword.text
                                    
                                    UserDefaults.standard.set(username, forKey: "USERNAME")
                                    UserDefaults.standard.set(password, forKey: "PASSWORD")
                                    
                                    
                                                                     
                                }
                                let arrayUserDef =  UserDefaults.standard.array(forKey: "ARRCHILD")
                                print("user deafult child array is",arrayUserDef)
                                if arrayUserDef != nil {
                                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "homeScreenVC") as! homeScreenVC
                                    self.navigationController?.pushViewController(VC, animated: true)
                                }
                                else if arrayUserDef == nil {
                                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "stepsToAddChlidVC") as! stepsToAddChlidVC
                                    self.navigationController?.pushViewController(VC, animated: true)
                                }
                            }
                            else {
                                "message"
                                var Message = JSON["message"] as? String ?? ""
                                self.alert(message: Message)
                            }
                        }
                    case .failure(let error):
                        self.hideActivityIndicator()
                       // APILoader.hide()
                        print("ERROR", error.localizedDescription)
                        self.alert(message: error.localizedDescription)
                }
            }
        }
        else {
            self.hideActivityIndicator()
            //APILoader.hide()
            alert(message: "No Internet Connection!!")
        }
    }
}
