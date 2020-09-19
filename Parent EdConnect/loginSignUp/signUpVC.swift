//
//  signUpVC.swift
//  Parent EdConnect
//
//  Created by Work on 10/06/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import MapKit
import LocalAuthentication

class signUpVC: UIViewController, CLLocationManagerDelegate {
    
    var reason:Bool = true
    
    var manager = CLLocationManager()
    
    var myCity:String?
    
    var myLat: Double?
    var myLong: Double?
    
    //var time:String?
    var deviceId:String?
    
    var iconClick = true
    
    
    @IBOutlet weak var imgAlex: UIImageView!    
    @IBOutlet weak var viewSignUp: UIView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRetypePassword: UITextField!
    
    
    @IBAction func btnTermsConditions(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "termsConditionPrivacyVC") as! termsConditionPrivacyVC
        VC.urlToShow = "termCondition"
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func btnPrivayPolicy(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "termsConditionPrivacyVC") as! termsConditionPrivacyVC
        VC.urlToShow = "privacypolicy"
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    @IBAction func btnSecureEntryPassword(_ sender: Any) {
        if(iconClick == true) {
            txtPassword.isSecureTextEntry = false
        } else {
            txtPassword.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    
    @IBAction func btnSecureEntryRetypePassword(_ sender: Any) {
        if(iconClick == true) {
            txtRetypePassword.isSecureTextEntry = false
        } else {
            txtRetypePassword.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginVC
        self.navigationController?.pushViewController(VC, animated: true)
        

    }
    
    @IBAction func btnCheckAction(_ sender: Any) {
        checkBox()
    }
    
    @IBAction func btnSignUpAction(_ sender: Any) {
        validationsTextFields()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        txtName.text = "test"
//        txtUserName.text = "test1"
//        txtPassword.text = "123456"
//        txtRetypePassword.text = "123456"
        
        self.StatusBarSetup()
        
        gradiantCrop()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        locc()
        deviceId = UIDevice.current.identifierForVendor?.uuidString
        print("the device id is \(deviceId)")
        //14C0C368-9EB3-4961-9AE6-E2336ABDB85C
        
        
        let Device = UIDevice.current
        let iosVersion = NSString(string: Device.systemVersion).doubleValue
        
        var systemVersion = UIDevice.current.systemVersion
        
        print("the ios version is",iosVersion)
        print("systemVersion is",systemVersion)
        
    }
    ///For Status bar Color Cahnge.
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    
}


extension signUpVC {
    func gradiantCrop() {
        btnSignUp.applyGradient(colours: [UIColor(red: 247.0/255.0, green: 149.0/255.0, blue: 72.0/255.0, alpha: 1.0), UIColor(red: 255.0/255.0, green: 196.0/255.0, blue: 83.0/255.0, alpha: 1.0)])
        
        btnSignUp.clipsToBounds = true
        btnSignUp.layer.cornerRadius = 10.0
        viewSignUp.clipsToBounds = true
        viewSignUp.layer.cornerRadius = 10.0
        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "Alex_login", withExtension: "gif")!)
        imgAlex.image = UIImage.gifImageWithData(imageData!)
    }
}

extension signUpVC {
    func checkBox() {
        reason = !reason
        if reason {
            btnCheck.setImage(UIImage(named: "unCheck"), for: .normal)
        }
        else {
            btnCheck.setImage(UIImage(named: "check"), for: .normal)
        }
    }
}


extension signUpVC {
    func validationsTextFields() {
        if (txtUserName.text?.isEmpty == true) &&
            (txtName.text?.isEmpty == true) &&
            (txtPassword.text?.isEmpty == true) &&
            (txtRetypePassword.text?.isEmpty == true) {
            alert(message: "Please fill the details!")
        }
            
        else if (txtUserName.text?.isEmpty == true) {
            alert(message: "Please enter a User Name!")
        }
        else if (txtName.text?.isEmpty == true) {
            alert(message: "Please enter the Name!")
        }
        else if (txtPassword.text?.isEmpty == true) {
            alert(message: "Please enter a password!")
        }
        else if (txtRetypePassword.text?.isEmpty == true) {
            alert(message: "Please Retype the Password!")
        }
        else if txtPassword.text != txtRetypePassword.text {
            alert(message: "Please Enter Same Passwords!")
            
            
        } else if (txtName.text?.isValidName == true) {
            alert(message: "Special Character, Symbols are not allowed with Name!")
        }
            
        else if  reason  {
            alert(message: "Please accept term and condtions!")
        }
            
        else {
            locationCheck()
        }
    }
}



//MARK:- **********_webservice_API_SignUp_****
//MARK:-
extension signUpVC {
    
    func signUpAPI() {
        
        var parentReg = "parent_registration"
        var Salt = "p@rentapp$ios@!2019"
        var apiKey = "8DDAD308E555C2AA38BFF8DBE"
        
//        var deviceId1 = "33ea076499f322ac"
//        var name = "ashok2"
//        var password = "123456"
        
        //0DEAD50C6BBA59FF22D33C994
        deviceId = UIDevice.current.identifierForVendor?.uuidString
        print("the device id is \(deviceId)")
        
        let Device = UIDevice.current
        let iosVersion = NSString(string: Device.systemVersion).doubleValue
        print("the ios version is",iosVersion)
        
        var logindetailsDataDict = NSMutableDictionary()
        logindetailsDataDict.addEntries(from: ["app_name":"Parent App", "city":myCity, "device_id":deviceId!, "is_new_app":"1", "latitude":myLat, "longitude":myLong, "name":txtName.text!, "operating_system_version":iosVersion, "password":txtPassword.text, "source": "ios", "username":txtUserName.text])
        
//        parent_registration:
//        ashok:
//        123456::33ea076499f322ac:
//        0DEAD50C6BBA59FF22D33C994:
//        p@rentapp$android@!2019
        
        var checkSum =  "\(parentReg):\(txtName.text!):\(txtPassword.text!)::\(deviceId!):\(apiKey):\(Salt)"
        
        var myChecksum = MD5(checkSum)
        
        var apiDetailDataDict = NSMutableDictionary()
        apiDetailDataDict.addEntries(from: ["apikey":apiKey,"checksum":myChecksum])
                
        let postData = [
            "action":parentReg,
            "api_details":apiDetailDataDict,
            "login_details":logindetailsDataDict
            ] as [String : Any]
        
        print("the data is API", postData)
        print("apiDetailDataDict is",apiDetailDataDict)
        print("logindetailsDataDict is",logindetailsDataDict)
        print("the chceksum String", checkSum)
        print("converted chceksum value ", myChecksum)
        
        if Reachability.isConnectedToNetwork() {
            showActivityIndicator()
            AF.request("\(baseUrl)api/v1.4/tabletregistration", method: .post, parameters: postData, encoding: JSONEncoding.default )
                
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            
                            self.hideActivityIndicator()
                            print("THE JSON RESULT",JSON)
                            
                            let Status = JSON["response_code"] as? Int ?? 0
                            print(Status)
                            
                            if Status == 9012 {                                      self.hideActivityIndicator()
                                print("Status is",Status)
                                
                                let detailDict = JSON["user_details"] as? NSDictionary ?? [:]
                                
                                let userID = detailDict.value(forKey: "user_id") as? Any ?? ""
                                
                                print("detailDict is",detailDict)
                                
                                UserDefaults.standard.set(userID, forKey: "USERID")
                                
                                let firstName = detailDict.value(forKey: "firstName") as? Any ?? ""
                                UserDefaults.standard.set(firstName, forKey: "NAME")
                                
                                print("user id is",userID)
                                
                                let VC = self.storyboard?.instantiateViewController(withIdentifier: "stepsToAddChlidVC") as! stepsToAddChlidVC
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


//Mark:************_Func_location_Authetication()_*************
//Mark:-
extension signUpVC {
    func locc() {
        if CLLocationManager.locationServicesEnabled() == true {
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied ||  CLLocationManager.authorizationStatus() == .notDetermined {
                manager.requestWhenInUseAuthorization()
            }
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.delegate = self
            manager.startUpdatingLocation()
            
        } else {
            print("This app need your location to verify your Authenticity")
        }
    }
    
    //MARK:- CLLocationManager Delegates
    //Mark:-
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //self.manager.stopUpdatingLocation()
        self.manager.startUpdatingLocation()
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        let latitude = region.center.latitude
        let long = region.center.longitude
        self.myLat = latitude
        self.myLong = long
        
        let myDoubleLat = String(latitude)
        let myDoubleLong = String(long)
        
        getAddressForAttendance(pdblLatitude: myDoubleLat, withLongitude:  myDoubleLong)
        
        print("lat is",self.myLat)
        print("long is" , self.myLong)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Unable to access your current location\(error.localizedDescription)")
    }
}



//MARK:- **********_getAddress_For_Attendance_************
//MARK:-
extension signUpVC {
    
    func getAddressForAttendance(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        
        if (pdblLatitude != "") && (pdblLongitude != "") {
            let lat: Double = Double("\(pdblLatitude)")!
            //21.228124
            let lon: Double = Double("\(pdblLongitude)")!
            //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon
            
            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
            
            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]
                    
                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country)
                        print("locality is",pm.locality)
                        print("sub locality is",pm.subLocality)
                        print(pm.thoroughfare)
                        print(pm.postalCode)
                        print(pm.subThoroughfare)
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                            self.myCity = pm.locality
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }
                        
                        print(" location is",addressString)
                        
                        
                        //self.location = addressString
                    }
            })
        }
    }
}



//MARK:- *******_func_locationCheck()_******
//Mark:
extension signUpVC {
    
    func locationCheck() {
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                alertMsgWithActionButton()
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                signUpAPI()
//                let VC = self.storyboard?.instantiateViewController(withIdentifier: "stepsToAddChlidVC") as! stepsToAddChlidVC
//                        self.navigationController?.pushViewController(VC, animated: true)
            }
        } else {
            print("Location services are not enabled")
        }
    }
}


//MARK:- *******_alertMsgWithActionButton()_*******
//Mark:-

extension signUpVC {
    
    func alertMsgWithActionButton() {
        // Create the alert controller
        let alertController = UIAlertController(title: "", message: " Please Allow Location Service from Settings. This app wants to access your Location for authetification.", preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            //self.alertMsgWithActionButton()
            self.locc()
        }
        // Add the actions
        alertController.addAction(okAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
}


