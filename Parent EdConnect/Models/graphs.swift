//
//  graphs.swift
//  Parent EdConnect
//
//  Created by Work on 19/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

//MARK:-********_graph_loader_with_single_to_multiple_color_***********
//MARK:-
class CircularArc: UIView ,CAAnimationDelegate{
    var speed = 10000.0
    var lineWidth :CGFloat = 8.0
    var layers : [CAShapeLayer] = []
    var startAng = 3*Double.pi/2
    var gameTimer: Timer?
    var arcArray : [Arc]?
    var i = 0, j = 0
    var total = 0.0
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    var myCenter : CGPoint = CGPoint (x: 0, y: 0)
    var circleRadius : CGFloat = 0.0
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("Animation END")
        if flag == true{
            if j < arcArray!.count{
                DrawMe()
            }
        }
    }
    func Start(array:[Arc] , lWidth: CGFloat){
        for l in layers{
            if self.layer.sublayers?.contains(l) == true{
                l.removeFromSuperlayer()
            }
        }
        layers.removeAll()
        lineWidth = lWidth
        arcArray = array
        arcArray = arcArray!.filter { $0.value != 0 }
        
        myCenter = CGPoint (x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
        circleRadius = center.x
        animation.duration = 1
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.delegate = self
        startAng = 3*Double.pi/2 - 2*Double.pi/180
        total = 0
        for arc in arcArray! {
            total += arc.value!
        }
        i = 1
        j = 0
        
        
        if arcArray!.count > 0{
            DrawMe()
        }
        
        
    }
    func DrawMe(){
        let arc = arcArray![j]
        DispatchQueue.main.async {
            self.drawLayer(value: Float(arc.value!), totalValue: Float(self.total), color: arc.color!)
        }
        
    }
    @objc func drawLayer(value: Float, totalValue: Float, color : UIColor ){
        
        let radius = Double(totalValue)/(2*Double.pi)
        let redAng =  Double(value) / radius
        
        let startRedAng = startAng
        var endRedAng = startRedAng + redAng
        startAng = endRedAng + Double.pi/180
        
        j += 1
        if j == arcArray!.count{
            endRedAng = 3*Double.pi/2 - 3*Double.pi/180
        }
        
        let redArcLayer   = CAShapeLayer()
        let redArcPath = UIBezierPath(arcCenter: myCenter, radius: circleRadius, startAngle: CGFloat(startRedAng), endAngle: CGFloat(endRedAng), clockwise: true)
        
        
        redArcLayer.path = redArcPath.cgPath
        redArcLayer.strokeColor = color.cgColor
        redArcLayer.fillColor = UIColor.clear.cgColor
        redArcLayer.lineWidth = self.lineWidth
        redArcLayer.strokeStart = 0
        redArcLayer.strokeEnd  = 1
        
        let distance =  redArcPath.flatness
        let time = (distance/CGFloat(speed))*10000
        animation.toValue = time
        redArcLayer.add(animation, forKey: "strokeEnd")
        
        self.layer.addSublayer(redArcLayer)
        
        layers.append(redArcLayer)
    }
    func distanceFrom(point1:CGPoint, point2:CGPoint) -> CGFloat {
        let xDist = (point2.x - point1.x);
        let yDist = (point2.y - point1.y);
        return sqrt((xDist * xDist) + (yDist * yDist));
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
//mark: Arc_values_for_loader_graph
//
class Arc {
    var color : UIColor?
    var value : Double?
    init(c:UIColor, v: Double) {
        color = c
        value = v
    }
}
//:-********************************* end
//:-*******************************************


//MARK:-********_graph_loader_with_needle_***********
//MARK:-

class CircularView: UIView {
    
    var n = 0
    var red = 0.0
    
    var myColor: UIColor = UIColor.white
    
    var redTimer: Timer?
    
    var startAng =
        Double.pi/2
    
    var redEndAng : CGFloat = 0.0
    var redMainAng : CGFloat = 0.0
    var redStartAng : CGFloat = 0.0
    
    let circleLayer   = CAShapeLayer()
    let redArcLayer   = CAShapeLayer()
    let redLineLayer   = CAShapeLayer()
    
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    var myCenter : CGPoint = CGPoint (x: 0, y: 0)
    var startRedPoint : CGPoint = CGPoint (x: 0, y: 0)
    var endRedPoint : CGPoint = CGPoint (x: 0, y: 0)
    
    var circleRadius : CGFloat = 0.0
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    func Start(value: Double, color: UIColor){
        animation.duration = 1
        animation.fromValue = 0.0
        animation.toValue = 1.0
        myCenter = CGPoint (x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        circleRadius = myCenter.x
        red = value
        myColor = color
        
        let redArcPath = UIBezierPath(arcCenter: myCenter, radius: circleRadius, startAngle: CGFloat(0), endAngle: CGFloat(2*Double.pi), clockwise: true)
        
        
        circleLayer.path = redArcPath.cgPath
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = 5
        circleLayer.strokeStart = 0
        circleLayer.strokeEnd  = 1
        circleLayer.lineCap = CAShapeLayerLineCap.round
        self.layer.addSublayer(circleLayer)
        
        RedLayer()
        
    }
    @objc func RedLayer(){
        
        let radius = (100.0)/(2*Double.pi)
        let redAng = red / radius
        
        var startRedAng = startAng
        
        //startRedAng = angularMod(angleRadian: startRedAng)
        var endRedAng = startRedAng + redAng
        // endRedAng = angularMod(angleRadian: endRedAng)
        if(redArcLayer.superlayer != nil){
            redArcLayer.removeFromSuperlayer()
            
            
        }
        let redArcPath = UIBezierPath(arcCenter: myCenter, radius: circleRadius, startAngle: CGFloat(startRedAng), endAngle: CGFloat(endRedAng), clockwise: true)
        
        redArcLayer.path = redArcPath.cgPath
        redArcLayer.strokeColor = myColor.cgColor
        redArcLayer.fillColor = UIColor.clear.cgColor
        redArcLayer.lineWidth = 5
        redArcLayer.strokeStart = 0
        redArcLayer.strokeEnd  = 1
        redArcLayer.add(animation, forKey: "strokeEnd")
        
        redArcLayer.lineCap = CAShapeLayerLineCap.round
        
        self.layer.addSublayer(redArcLayer)
        if redLineLayer.superlayer != nil{
            redLineLayer.removeFromSuperlayer()
        }
        
        let linePath = UIBezierPath()
        
        linePath.move(to: myCenter)
        
        var point = CGPoint(x: circleRadius * CGFloat( cos(startRedAng + Double.pi/360)), y: circleRadius * CGFloat(sin(startRedAng + Double.pi/360)))
        
        
        point =  CGPoint(x: myCenter.x + point.x, y: myCenter.y + point.y)
        startRedPoint = point
        var point1 = CGPoint(x: circleRadius * CGFloat( cos(endRedAng - Double.pi/360)), y: circleRadius * CGFloat(sin(endRedAng - Double.pi/360)))
        point1 =  CGPoint(x: myCenter.x + point1.x, y: myCenter.y + point1.y)
        endRedPoint = point1
        linePath.addLine(to: point)
        
        redLineLayer.path = linePath.cgPath
        redLineLayer.strokeColor = myColor.cgColor
        redLineLayer.fillColor = UIColor.clear.cgColor
        redLineLayer.lineWidth = 5
        redLineLayer.strokeStart = 0
        redLineLayer.strokeEnd  = 1
        
        redLineLayer.lineCap = CAShapeLayerLineCap.round
        
        
        var diffTime = Double.pi/(redAng*360)
        
        if diffTime < 0{
            
            diffTime = (-1) * diffTime
        }
        
        
        self.layer.addSublayer(redLineLayer)
        redEndAng = CGFloat(endRedAng)
        redStartAng = CGFloat(startRedAng)
        redMainAng = redStartAng
        redTimer = Timer.scheduledTimer(timeInterval: diffTime, target: self, selector: #selector(RotateRedLine), userInfo: nil, repeats: true)
        
    }
    
    @objc func RotateRedLine(){
        n += 2
        //           redMainAng = CGFloat(angularMod(angleRadian: Double(redMainAng)))
        //           redStartAng = CGFloat(angularMod(angleRadian: Double(redStartAng)))
        //           redEndAng = CGFloat(angularMod(angleRadian: Double(redEndAng)))
        let linePath = UIBezierPath()
        linePath.move(to: myCenter)
        redMainAng = redMainAng + CGFloat(Double.pi/(360))
        //  redMainAng = CGFloat(angularMod(angleRadian: Double(redMainAng)))
        var point = CGPoint(x: circleRadius * CGFloat( cos(redMainAng)), y: circleRadius * CGFloat(sin(redMainAng)))
        point =  CGPoint(x: myCenter.x + point.x, y: myCenter.y + point.y)
        if redMainAng <= redEndAng{
            linePath.addLine(to: point)
            redLineLayer.path = linePath.cgPath
            redLineLayer.strokeColor = myColor.cgColor
            redLineLayer.fillColor = UIColor.clear.cgColor
            redLineLayer.lineWidth = 5
            redLineLayer.strokeStart = 0
            redLineLayer.strokeEnd  = 1
            
            redLineLayer.lineCap = CAShapeLayerLineCap.round
            
            redLineLayer.removeFromSuperlayer()
            self.layer.addSublayer(redLineLayer)
            
        }
        else{
            redTimer?.invalidate()
            if(n<=5){
                
                RedLayer()
            }
        }
        
        
    }
    func angularMod( angleRadian : Double)->Double{
        if angleRadian > 2*Double.pi{
            let modStartGreenAng = angleRadian/(2*Double.pi)
            let intPart = Double(Int(modStartGreenAng))
            let remPart = modStartGreenAng - intPart
            let remainder = (2*Double.pi) * remPart
            return remainder
        }
        else{
            return angleRadian
        }
    }
    func percentMod( angleRadian : Double)->Double{
        if angleRadian > 2*Double.pi{
            let modStartGreenAng = angleRadian/(2*Double.pi)
            let intPart = Double(Int(modStartGreenAng))
            let remPart = modStartGreenAng - intPart
            let remainder = (2*Double.pi) * remPart
            return remainder
        }
        else{
            return angleRadian
        }
    }
    func angleBetweenPoints(p1 : CGPoint, p2 : CGPoint)->CGFloat{
        let angle = atan2f(Float(p2.y - p1.y), Float(p2.x - p1.x))
        return CGFloat(angle)
    }
    func isPointIsInsideTwoPoints(p:CGPoint, p1:CGPoint,p2:CGPoint)->Bool{
        let v1 = (p1.x - myCenter.x)*(p.y - center.y) - (p.x - myCenter.x)*(p1.y - myCenter.y)
        let v2 = (p2.x - myCenter.x)*(p.y - myCenter.y) - (p.x - myCenter.x)*(p2.y - myCenter.y)
        if (v1>=0 && v2<=0) || (v1<=0 && v2>=0){
            return true
        }
        return false
    }
}
//:-********************************* end
//:-*******************************************

//MARK:- ******_Bar_chart_for_two_values_*****
//MARK:-

class BarChartView: UIView {
    private var scrollView: UIScrollView = UIScrollView()
    var bar1Ht = 0.0, bar2Ht = 0.0
    var multiply:Double = 10
    var  barLayer1 = BarView(), barLayer2 = BarView()
    func SetBar(value1:Float, value2:Float, multipl:Double){
        multiply = multipl
        scrollView = UIScrollView(frame: self.bounds)
        self.addSubview(scrollView)
        bar1Ht = Double(value1)
        bar2Ht = Double(value2)
        
        barLayer1 = BarView(frame: CGRect(x: Int(10.0), y: 10, width: 50, height: Int(bar1Ht*multiply)))
        
        barLayer1.tag = 1
        barLayer1.backgroundColor = #colorLiteral(red: 0.9523274302, green: 0.5835757852, blue: 0.2794597745, alpha: 1)
        
        barLayer2 = BarView(frame: CGRect(x: Int(55.0), y: 10, width: 50, height: Int(bar2Ht*multiply)))
        
        barLayer2.backgroundColor = #colorLiteral(red: 0.9811117053, green: 0.8546318412, blue: 0.7472247481, alpha: 1)
        barLayer2.tag = 2
        scrollView.addSubview(barLayer1)
        scrollView.addSubview(barLayer2)
        let ht: CGFloat = bar1Ht > bar2Ht ? CGFloat(bar1Ht * multiply) : CGFloat(bar2Ht * multiply)
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: ht)
        scrollView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        //        scrollView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi - 3.14159));
    }
}

class BarView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
        // roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
    }
    
}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
//:-********************************* end
//:-*******************************************
