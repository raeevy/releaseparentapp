//
//  Gradient.swift
//  Parent EdConnect
//
//  Created by Work on 08/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import Foundation
import UIKit

//MARK:- ****************Func--applyGradient(), Sidecrop()******
//MARK:-
extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIView {
    func gradientViolet(){
        applyGradient(colours: [UIColor(red: 111.0/255.0, green: 0.0/255.0, blue: 189.0/255.0, alpha: 1.0), UIColor(red: 89.0/255.0, green: 202.0/255.0, blue: 255.0/255.0, alpha: 1.0)])
    }
    
    func gradientPurple(){
        applyGradient(colours: [UIColor(red: 224.0/255.0, green: 64.0/255.0, blue: 251.0/255.0, alpha: 1.0), UIColor(red: 83.0/255.0, green: 109.0/255.0, blue: 254.0/255.0, alpha: 1.0)])
    }
}


extension UIButton {
    func btnGradientCrop(UIButton: UIButton) {
        UIButton.applyGradient(colours: [UIColor(red: 247.0/255.0, green: 149.0/255.0, blue: 72.0/255.0, alpha: 1.0), UIColor(red: 255.0/255.0, green: 196.0/255.0, blue: 83.0/255.0, alpha: 1.0)])
        UIButton.clipsToBounds = true
        UIButton.layer.cornerRadius = 10.0
    }
}

extension UIView {
    func cornerRadius() {
        clipsToBounds = true
        layer.cornerRadius = 10.0
    }
    func gradientBlueWithCornerRadius(){
        clipsToBounds = true
        layer.cornerRadius = 10.0
        applyGradient(colours: [UIColor(red: 88.0/255.0, green: 150.0/255.0, blue: 253.0/255.0, alpha: 1.0), UIColor(red: 21.0/255.0, green: 59.0/255.0, blue: 142.0/255.0, alpha: 1.0)])
    }
    
    func gradientBlue1(){
        applyGradient(colours: [UIColor(red: 88.0/255.0, green: 150.0/255.0, blue: 253.0/255.0, alpha: 1.0), UIColor(red: 21.0/255.0, green: 59.0/255.0, blue: 142.0/255.0, alpha: 1.0)])
    }
    
    func gradientBlue2(){
        applyGradient(colours: [UIColor(red: 84.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0), UIColor(red: 10.0/255.0, green: 29.0/255.0, blue: 122.0/255.0, alpha: 1.0)])
        clipsToBounds = true
        layer.cornerRadius = 10.0
    }
    
    func gradientYellow() {
        applyGradient(colours: [UIColor(red: 247.0/255.0, green: 149.0/255.0, blue: 72.0/255.0, alpha: 1.0), UIColor(red: 255.0/255.0, green: 196.0/255.0, blue: 83.0/255.0, alpha: 1.0)])
    }
    
    func gradientYellow2() {
        applyGradient(colours: [UIColor(red: 255.0/255.0, green: 196.0/255.0, blue: 37.0/255.0, alpha: 1.0), UIColor(red: 227.0/255.0, green: 156.0/255.0, blue: 34.0/255.0, alpha: 1.0)])
    }
    func cropMskToBund(){
        layer.cornerRadius = 10.0
        layer.masksToBounds = true;
    }
}
