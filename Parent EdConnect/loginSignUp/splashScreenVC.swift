//
//  splashScreenVC.swift
//  Parent EdConnect
//
//  Created by Work on 24/06/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire

class splashScreenVC: UIViewController {
  var deviceId:String?
  var UserId = UserDefaults.standard.value(forKey: "USERID")
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.StatusBarSetup()
    deviceId = UIDevice.current.identifierForVendor?.uuidString
                             
    if self.UserId != nil {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "homeScreenVC") as! homeScreenVC
            self.navigationController?.pushViewController(VC, animated: false)
        }
    else if UserId == nil && deviceId != nil  {
        chcekDeviceStatusAPI()
        }
    }
    
    ///For Status bar Color Cahnge.
       override var preferredStatusBarStyle: UIStatusBarStyle {
             return .lightContent
       }
}
extension splashScreenVC {
        func chcekDeviceStatusAPI() {
//            0DEAD50C6BBA59FF22D33C994
            var Salt = "p@rentapp$ios@!2019"
            var apiKey = "8DDAD308E555C2AA38BFF8DBE"
//             deviceId = UIDevice.current.identifierForVendor?.uuidString
//                   print("the device id is \(deviceId)")
            
            var checkSum =  "\(deviceId!):\(apiKey):\(Salt)"
            var myChecksum = MD5(checkSum)
            print("chceksum data in string",checkSum)
            print("converted checksum",myChecksum)

            let headers: HTTPHeaders = [
                "accept": "application/json",
                "content-type": "application/json",
            ]
            
            if Reachability.isConnectedToNetwork() {
//                showActivityIndicator()
                AF.request("\(baseUrl)api/v1.0/checkdevice?device_id=\(deviceId!)&apikey=\(apiKey)&checksum=\(myChecksum!)", method: .get, encoding: JSONEncoding.default, headers: headers )
                    
                    .responseJSON { (response) in
                        switch response.result {
                        case .success:
                            if let JSON = response.value as? [String: Any]  {
                                
//                                self.hideActivityIndicator()
                                print("THE JSON RESULT",JSON)
                                
                                let Status = JSON["status"] as? Int ?? 0
                                print("the status is",Status)
                                if Status == 1 {
                                    
                                    ////     self.hideActivityIndicator()
//                                    print("Status is",Status)
                                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginVC
                                    self.navigationController?.pushViewController(VC, animated: false)
//
//                                    let storyBord = UIStoryboard(name: "Home", bundle: nil)
//                                    let VC = storyBord.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
//                                    self.navigationController?.pushViewController(VC, animated: true)
                                    
                                    
                                } else if Status == 0 {
//
                                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpVC
                                    self.navigationController?.pushViewController(VC, animated: false)
                                            
//                                    let storyBord = UIStoryboard(name: "Home", bundle: nil)
//                                    let VC = storyBord.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
//                                    self.navigationController?.pushViewController(VC, animated: true)
                                }
                                else {
                                    
                                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpVC
                                    self.navigationController?.pushViewController(VC, animated: false)
                                    
                                    
//                                    let storyBord = UIStoryboard(name: "Home", bundle: nil)
//                                    let VC = storyBord.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
//                                    self.navigationController?.pushViewController(VC, animated: true)
                                }
                            }
                        case .failure(let error):
                            
//                            print("ERROR", error.localizedDescription)
//                            self.hideActivityIndicator()
                            
                            let VC = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpVC
                            self.navigationController?.pushViewController(VC, animated: false)
                   }
                }
            }
            else {
                self.hideActivityIndicator()
                alert(message: "No Internet Connection!!")
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpVC
                self.navigationController?.pushViewController(VC, animated: false)
        }
    }
}

