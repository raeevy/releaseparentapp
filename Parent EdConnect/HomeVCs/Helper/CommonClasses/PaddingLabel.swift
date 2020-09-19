//
//  PaddingLabel.swift
//  LearningApp
//
//  Created by Developer on 06/02/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
   /* @IBInspectable var topInset: CGFloat = 10.0
    @IBInspectable var bottomInset: CGFloat = 10.0
    @IBInspectable var leftInset: CGFloat = 10.0
    @IBInspectable var rightInset: CGFloat = 10.0 */
    var topInset: CGFloat = 0
    var bottomInset:  CGFloat = 0
    var leftInset: CGFloat = 0
    var rightInset: CGFloat = 0
   
    
   /* required init(withInsets top: CGFloat, _ bottom: CGFloat,_ left: CGFloat,_ right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: CGRect.zero)
    } */
 
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
   
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            
            contentSize.height += topInset + bottomInset + 30.0
            contentSize.width += leftInset + rightInset
            return contentSize
           // return CGSize(width: max(contentSize.width + leftInset + rightInset, 10000), height: contentSize.height + topInset + bottomInset)
        }
        
       //
    }

}
/*
 
 class PaddingLabel: UILabel {
 

 
 
 
 
 
 
 */
