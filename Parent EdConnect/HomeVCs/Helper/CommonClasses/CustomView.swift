//
//  CustomView.swift
//  LearningApp
//
//  Created by Developer on 16/01/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
@IBDesignable
class CustomView: UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }

}
@IBDesignable
class CustomLabel: UILabel {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
 
}


@IBDesignable
class CustomTableView: UITableView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
}
extension UIView {
    func removeGradient(_ identifier:String)  {
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                if layer.name == identifier{
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    
    func addGradient(_ identifier:String = "GradientName" ,gradientColor:UIColor = voiletColor , lightColor:UIColor = voiletColor,  cornerRadius : CGFloat = 0.0 ,width : CGFloat = 0.0 ,height : CGFloat = 0.0)  {
        let gradient = CAGradientLayer()
        var gradientFrame1 = self.bounds
        if width > 0.0 {
           gradientFrame1.size.width = width
        }else{
            gradientFrame1.size.width = self.frame.size.width
        }
        if height > 0.0 {
            gradientFrame1.size.height = height
        }else{
            gradientFrame1.size.height = self.frame.size.height
        }
        gradient.frame = gradientFrame1
        gradient.name = identifier
        gradient.startPoint = CGPoint(x: 0.0, y: 0.7)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.7)
        gradient.cornerRadius = cornerRadius
        gradient.colors = [gradientColor.cgColor, lightColor.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
    }
}


class ArrowView : UIView {
    var arrorBackgroundColor: UIColor = voiletColor
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fill(bounds)
        
        ctx.beginPath()
        ctx.move(to: CGPoint(x: 0, y: bounds.maxY))
        ctx.addLine(to: CGPoint(x: bounds.midX, y: bounds.minY))
        ctx.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        ctx.addLine(to: CGPoint(x: 0, y: bounds.maxY))
        ctx.closePath()
        
        ctx.setFillColor(arrorBackgroundColor.cgColor)
        ctx.fillPath()
    }
}
