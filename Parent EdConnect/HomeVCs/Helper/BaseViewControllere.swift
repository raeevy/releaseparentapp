//
//  BaseViewController.swift
//  LearningApp
//
//  Created by Developer on 16/01/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
//import SVProgressHUD
import IQKeyboardManagerSwift

class BaseViewController: UIViewController {

    let window = APPDELEGATE.window
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        // Do any additional setup after loading the view.
     //   NotificationCenter.default.addObserver(self, selector: #selector(networkCheckSelector), name: NSNotification.Name.noInternet, object: nil)
        print("Screen_Name = \(self)")
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @objc func networkCheckSelector(_ observe:NSNotification){
        
    }
    
    
    
    func showProgressView() {
            self.openLoader()
        
//        SVProgressHUD.show()
//        SVProgressHUD.setDefaultMaskType(.clear)

    }
    func dismissProgressView() {
        self.hideLoader()
//       SVProgressHUD.dismiss()
    }
    
    func addGradientOnButton(sender:UIButton, layerName:String,lightColor:UIColor,darkColor:UIColor) {
        if let sublayers = sender.layer.sublayers {
            for layer in sublayers {
                if layer.name == layerName{
                    layer.removeFromSuperlayer()
                }
            }
        }
        let gradient = CAGradientLayer()
        gradient.frame = sender.bounds
        gradient.name = layerName
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = [lightColor.cgColor, darkColor.cgColor]
        sender.layer.insertSublayer(gradient, at: 0)
    }
   
    func addGradientOnLabel(sender:UILabel, layerName:String,lightColor:UIColor,darkColor:UIColor) {
        if let sublayers = sender.layer.sublayers {
            for layer in sublayers {
                if layer.name == layerName{
                    layer.removeFromSuperlayer()
                }
            }
        }
        sender.layer.cornerRadius = sender.frame.size.width/2
        sender.layer.masksToBounds = true
       
        let gradient = CAGradientLayer()
        //For Continue Btn
        gradient.frame = sender.bounds
        gradient.name = layerName
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = [lightColor.cgColor, darkColor.cgColor]
        sender.layer.insertSublayer(gradient, at: 0)
    }
    
    func addGradientOnView(sender:UIView, layerName:String,lightColor:UIColor,darkColor:UIColor) {
        if let sublayers = sender.layer.sublayers {
            for layer in sublayers {
                if layer.name == layerName{
                    layer.removeFromSuperlayer()
                }
            }
        }
        //        sender.layer.cornerRadius = 8.0
        //        sender.layer.masksToBounds = true
        let gradient = CAGradientLayer()
        //For Continue Btn
        gradient.frame = sender.bounds
        gradient.name = layerName
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = [lightColor.cgColor, darkColor.cgColor]
        sender.layer.insertSublayer(gradient, at: 0)
    }
    func showAlert(message: String,type: UIAlertController.Style = .alert){
        var titleExtramarks = ""
        var titleOk = ""
//        if let dic = LocalizedStringManager.sharedObj.stringList{
//            titleExtramarks = dic["extramarks"] as? String ?? "Extramarks"
//            titleOk = dic["ok_caps"] as? String ?? "Ok"
//        }
        let alertController = UIAlertController(title: titleExtramarks, message: message, preferredStyle: DEVICE_TYPE == .pad ? .alert: type)
        let okAction = UIAlertAction(title: titleOk, style: .default,handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func openLoader()  {
        DispatchQueue.main.async {
            let loaderView = UIView.init(frame: (self.window?.frame)!)
            loaderView.frame = (self.window?.bounds)!
            loaderView.backgroundColor = .clear
            loaderView.alpha = 0.3
            loaderView.tag = 1001

            let loaderImage = UIImageView.init(frame: CGRect(x: (loaderView.frame.size.width/2)-25, y: (loaderView.frame.size.height/2)-25, width: 50, height: 50))

            let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "cube-256", withExtension: "gif")!)
       //     loaderImage.image = UIImage.gifImageWithData(imageData!)
            loaderImage.tag = 1002
            self.window?.makeKeyAndVisible()
            
            if ((self.window?.viewWithTag(1001)) != nil) {
                return
            }
            self.window?.addSubview(loaderView)
            self.window?.addSubview(loaderImage)
        }
    }
    func hideLoader()  {
        DispatchQueue.main.async {
            let loaderView = self.window?.viewWithTag(1001)
            let loaderImg = self.window?.viewWithTag(1002)
            loaderImg?.removeFromSuperview()
            loaderView?.removeFromSuperview()
        }
        
    }
    func openLoaderForAlreadyMainThred()
    {
            let loaderView = UIView.init(frame: (self.window?.frame)!)
            loaderView.frame = (self.window?.bounds)!
            loaderView.backgroundColor = .clear
            loaderView.alpha = 0.3
            loaderView.tag = 1001

            let loaderImage = UIImageView.init(frame: CGRect(x: (loaderView.frame.size.width/2)-25, y: (loaderView.frame.size.height/2)-25, width: 50, height: 50))

            let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "cube-256", withExtension: "gif")!)
           // loaderImage.image = UIImage.gifImageWithData(imageData!)
            loaderImage.tag = 1002
            self.window?.makeKeyAndVisible()
            
            if ((self.window?.viewWithTag(1001)) != nil) {
                return
            }
            self.window?.addSubview(loaderView)
            self.window?.addSubview(loaderImage)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

