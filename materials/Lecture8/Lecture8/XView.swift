//
//  XView.swift
//  Lecture8
//
//  Created by Van Simmons on 10/3/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class XView: UIView {

    var fillColor = UIColor(red: 1.0, green: 0.5, blue: 0.7, alpha: 1.0)
    var xColor = UIColor.black
    var xProportion = CGFloat(1.0)
    var widthProportion = CGFloat(0.05)

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        //set up the width and height variables
        //for the horizontal stroke
        let lineWidth: CGFloat = sqrt(bounds.width*bounds.height) * widthProportion
        let plusHeight: CGFloat = bounds.height * xProportion
        let plusWidth: CGFloat = bounds.width * xProportion
        
        //create the path
        var plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = lineWidth
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.move(to: CGPoint(
            x:bounds.width/2 - plusWidth/2,
            y:bounds.height/2 - plusHeight/2))
        
        //add a point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(
            x:bounds.width/2 + plusWidth/2,
            y:bounds.height/2 + plusHeight/2))
        
        //draw the stroke
        UIColor.cyan.setStroke()
        plusPath.stroke()
        
        plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = lineWidth
//move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.move(to: CGPoint(
            x:bounds.width/2  - plusWidth/2,
            y:bounds.height/2 + plusHeight/2))
        
        //add a point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(
            x:bounds.width/2 + plusWidth/2,
            y:bounds.height/2 - plusHeight/2))
        
        //set the stroke color
        xColor.setStroke()
        
        //draw the stroke
        plusPath.stroke()
    }
}
