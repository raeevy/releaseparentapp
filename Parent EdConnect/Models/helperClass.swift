//
//  helperClass.swift
//  Parent EdConnect
//
//  Created by Work on 11/06/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func graphLoader(UIView: UIView) {
        
            let red = 6.0
            let green = 30.0
            let gray = 6.0
            let radius = (red+green+gray)/(2*Double.pi)
            let redAng = red / radius
            let greenAng = green / radius
            let grayAng = gray / radius
            
            //** green
            let startGreenAng = 3*Double.pi/2
            let endGreenAng = startGreenAng + greenAng
            let center = CGPoint (x: UIView.frame.size.width / 2, y: UIView.frame.size.height / 2)
           
            
         
            let circleRadius = UIView.frame.size.width / 2
            var greenArcLayer   = CAShapeLayer()
            let greenArcPath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: CGFloat(startGreenAng), endAngle: CGFloat(endGreenAng), clockwise: true)
                
            greenArcLayer.path = greenArcPath.cgPath
            greenArcLayer.strokeColor = #colorLiteral(red: 0.4311445951, green: 0.9026629329, blue: 0.7239783406, alpha: 1)
            greenArcLayer.fillColor = UIColor.white.cgColor
            greenArcLayer.lineWidth = 8
            greenArcLayer.strokeStart = 0
            greenArcLayer.strokeEnd  = 1
            greenArcLayer.lineCap = CAShapeLayerLineCap.round
            UIView.layer.addSublayer(greenArcLayer)
            
            //*** red
            let startRedAng = endGreenAng + Double.pi/360
            let endRedAng = startRedAng + redAng
            var redArcLayer   = CAShapeLayer()
            let redArcPath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: CGFloat(startRedAng), endAngle: CGFloat(endRedAng), clockwise: true)
            redArcLayer.path = redArcPath.cgPath
            redArcLayer.strokeColor = #colorLiteral(red: 0.9377772212, green: 0.4243853092, blue: 0.3900203705, alpha: 1)
            redArcLayer.fillColor = UIColor.white.cgColor
            redArcLayer.lineWidth = 8
            redArcLayer.strokeStart = 0
            redArcLayer.strokeEnd  = 1
            
            redArcLayer.lineCap = CAShapeLayerLineCap.round
            
            
            
            UIView.layer.addSublayer(redArcLayer)
            let basicAnimation = CABasicAnimation()
            
            //*** grey
            let startGrayAng = endRedAng + Double.pi/360
            let endGrayAng = startGrayAng + grayAng
            var grayArcLayer   = CAShapeLayer()
            
            let grayArcPath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: CGFloat(startGrayAng), endAngle: CGFloat(endGrayAng), clockwise: true)
        
            grayArcLayer.path = grayArcPath.cgPath
            grayArcLayer.strokeColor = #colorLiteral(red: 0.5921034217, green: 0.5921911597, blue: 0.592084229, alpha: 1)
            grayArcLayer.fillColor = UIColor.white.cgColor
            grayArcLayer.lineWidth = 6
            grayArcLayer.strokeStart = 0
            grayArcLayer.strokeEnd  = 1
            grayArcLayer.lineCap = CAShapeLayerLineCap.round

        //   CABasicAnimation =
        UIView.layer.addSublayer(grayArcLayer)
        
    }
}


class APILoader {
    static var activeView:UIView? = nil
    //MARK:- Show Loader
    //MARK:-
    class func show()  {
        DispatchQueue.main.async {
            let loaderView = UIView.init(frame: (APPDELEGATE.window?.frame)!)
            loaderView.frame = (APPDELEGATE.window?.bounds)!
            loaderView.backgroundColor = .clear
            loaderView.alpha = 0.3
            loaderView.tag = 1001
            let loaderImage = UIImageView.init(frame: CGRect(x: (loaderView.frame.size.width/2)-25, y: (loaderView.frame.size.height/2)-25, width: 50, height: 50))
            let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "cube-256", withExtension: "gif")!)
            loaderImage.image = UIImage.gifImageWithData(imageData!)
            loaderImage.tag = 1002
            guard APILoader.activeView == nil else{
                APILoader.activeView?.addSubview(loaderView)
                APILoader.activeView?.addSubview(loaderImage)
                APILoader.activeView?.bringSubviewToFront(loaderView)
                APILoader.activeView?.bringSubviewToFront(loaderImage)
                return
            }
            
            APPDELEGATE.window?.makeKeyAndVisible()
            if ((APPDELEGATE.window?.viewWithTag(1001)) != nil) {
                return
            }
            APPDELEGATE.window?.addSubview(loaderView)
            APPDELEGATE.window?.addSubview(loaderImage)
        }
    }
    //MARK:- Hide OR Dismiss Loader
    //MARK:-
    class func hide()  {
        DispatchQueue.main.async {
            guard APILoader.activeView == nil else{
                let loaderView =     APILoader.activeView?.viewWithTag(1001)
                let loaderImg =    APILoader.activeView?.viewWithTag(1001)
                loaderImg?.removeFromSuperview()
                loaderView?.removeFromSuperview()
                
                return
            }
            
            let loaderView = APPDELEGATE.window?.viewWithTag(1001)
            let loaderImg = APPDELEGATE.window?.viewWithTag(1002)
            loaderImg?.removeFromSuperview()
            loaderView?.removeFromSuperview()
        }
    }
}

