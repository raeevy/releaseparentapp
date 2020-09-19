//
//  QRScannerVC.swift
//  Parent EdConnect
//
//  Created by Work on 13/06/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import AVFoundation
import  Alamofire

class QRScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var video = AVCaptureVideoPreviewLayer()
    
    var UserId = UserDefaults.standard.value(forKey: "USERID")
    var parentId = UserDefaults.standard.value(forKey: "PARENTID")
    
    @IBOutlet weak var btnProceed: UIButton!
    @IBOutlet weak var txtQrCode: UITextField!
    @IBAction func btnProceedAction(_ sender: Any) {
     
        validation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
          //CaptureQr()
        StatusBarSetup()
        cropShadow()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
             return .lightContent
       }       
}



extension QRScannerVC {
    func cropShadow() {
       btnProceed.layer.borderColor = #colorLiteral(red: 0.9723195434, green: 0.7530776262, blue: 0.3175763786, alpha: 1)
       btnProceed.layer.borderWidth = 1.5
       btnProceed.layer.cornerRadius = 18.0
       btnProceed.layer.masksToBounds = true;
       }
}

//Mark:- *********_function_QR_scanner_***********
//Mark:-

extension QRScannerVC {
    func CaptureQr(){
        let session = AVCaptureSession()
        //Define capture devcie
        //          let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        AVCaptureDevice.default(for: .video)
        let captureDevice = AVCaptureDevice.default(for: .video)
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }
        catch
        {
            alert(message: "Somthing went wrong, Try again ")
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        //self.view.bringSubview(toFront: square)
        session.startRunning()
    }
    
//Mark:- *********_func_captureOutput_from_video_***********
//Mark:-
    
        func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection) {
            if metadataObjects != nil && metadataObjects.count != 0
            {
                if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
                {
                    if object.type == AVMetadataObject.ObjectType.qr
                    {
                        //txtQrCode.text = object.stringValue
                        let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (nil) in
                            self.txtQrCode.text = object.stringValue
                   }))
               }
            }
         }
     }
}

extension QRScannerVC {
        func addChildApi() {
            let action = "child_mapping"
            var QRcode = "\(txtQrCode.text!)"
            
            let deviceId = UIDevice.current.identifierForVendor?.uuidString
            print("the device id is \(deviceId)")
            
            let Device = UIDevice.current
            let iosVersion = NSString(string: Device.systemVersion).doubleValue
            print("the ios version is",iosVersion)
            
            var logindetailsDataDict = NSMutableDictionary()
            logindetailsDataDict.addEntries(from:
                ["app_name":"Parent App",
                "device_id":deviceId,
                "operating_system_version":iosVersion,
                "parent_id":parentId,
                "qr_code_value":QRcode,
                "source":"ios"])
            
            print("api key in checksum",apikeyMain)
            print("parent ID in checksum",parentId!)
            
            var checkSum = "\(action):\(parentId!)::\(QRcode):\(apikeyMain):\(saltMain)"
            
            var myChecksum = MD5(checkSum)
            
            var apiDetailDataDict = NSMutableDictionary()
            apiDetailDataDict.addEntries(from: ["apikey":apikeyMain,"checksum":myChecksum!])
            
            let postData = [
                "action":action,
                "api_details": apiDetailDataDict,
                "login_details":logindetailsDataDict
                ] as [String : Any]
            
            print("the data is API", postData)
            print("apiDetailDataDict is",apiDetailDataDict)
            print("logindetailsDataDict is",logindetailsDataDict)
            print("the chceksum String", checkSum)
            print("converted chceksum value ", myChecksum!)
            
            if Reachability.isConnectedToNetwork() {
                showActivityIndicator()
                AF.request("http://emstage.extramarks.com/api/v1.4/tabletregistration", method: .post, parameters: postData, encoding: JSONEncoding.default )
                    
                    .responseJSON { (response) in
                        switch response.result {
                        case .success:
                            if let JSON = response.value as? [String: Any]  {
                                
                                self.hideActivityIndicator()
                                print("THE JSON RESULT",JSON)
                         
                                
                                let Status = JSON["response_code"] as? Int ?? 0
                                print("the status is",Status)
                                                                
                                if Status == 81006 {                                      self.hideActivityIndicator()
                                    print("Status is",Status)
                                    
                                    let detailDict = JSON["child_details"] as? NSArray
                                    
                                    print(" the child details dict", detailDict)
                                    
                                    let childInfoArr = detailDict?.object(at: 0) as? NSDictionary ?? [:]
                                    
                                    print("the child info array is ", childInfoArr)
                                    
                                    let child_name = childInfoArr.value(forKey: "child_name") as?
                                        String ?? ""
                                    
                                    let email = childInfoArr.value(forKey: "email") as?
                                        String ?? ""
                                    
                                    
                                    let classId = childInfoArr.value(forKey: "class_id") as? Any ?? ""
                                    
                                    
                                    UserDefaults.standard.set(classId, forKey: "CLASSID")
                                    
                                    print("child_name is", child_name)
                                    print("email is", email)
                                    print("child_name is", child_name)
                                    print("classId is", classId)
                                    
                                    if child_name != nil || email != nil {
                                        let VC = self.storyboard?.instantiateViewController(withIdentifier: "childDetailVC") as! childDetailVC
                                        VC.name = child_name
                                        VC.email = email
                                        self.navigationController?.pushViewController(VC, animated: false)
                                    }
                                    else {
                                        self.alert(message: "somthing went wrong")
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

extension QRScannerVC {
    func validation() {
        if txtQrCode.text?.isEmpty == true {
            alert(message: "Enter a QR Code", title: "QR Code Empty!")
        }
        else {
            
            if parentId != nil {
                addChildApi()
            }
            else {
               alert(message: "Parent-ID is not valid!")
            }
            
        }
    }
}


extension QRScannerVC {
//    THE JSON RESULT ["child_details": <__NSSingleObjectArrayI 0x6000024d2cc0>(
//    {
//    "achieve_status" = 0;
//    "board_id" = 180;
//    "board_name" = CBSE;
//    "child_mobile_number" = "+91-9056845986";
//    "child_name" = Abhishek;
//    "child_user_id" = 67567508;
//    "class = X;"
//    "xxj h" "in"
//     "czvxv"
//    "instgaram"
//    "class_id" = 36;
//    "email = "tripathiabhishek1289@gmail.com";
//    "last_active_on" = "2020-06-25 14:17:32";
//    "lead_id" = "LD-2019-12-31-07375";
//    "profile_pic" = "http://developer.extramarks.com/uploads/profileimages/2020/03/67567508.jpg";
//""
//    }
//    ""
//    )
//    , "response_code": 81006, "message": Successfully mapped, "registration_details": {
//        name = Test;
//        "profile_pic" = "http://developer.extramarks.com/uploads/profileimages/avtar1.png";
//        userid = 990754;
//        username = Test1;
//    }, "status": 1]
    
}
