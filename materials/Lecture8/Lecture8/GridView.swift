//
//  GridView.swift
//  Lecture8
//
//  Created by Van Simmons on 10/3/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    
    var rows: Int = 4
    var cols: Int = 4
    
    @IBInspectable var cellColor = UIColor.yellow
    @IBInspectable var gridColor = UIColor.cyan

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        //create the path
        let gridPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        gridPath.lineWidth = 2.0
        
        _ = ( 0 ... cols).map {
            let fraction = CGFloat($0) / CGFloat(cols)
        gridPath.move(to: CGPoint(
            x:rect.origin.x + ( fraction * rect.size.width),
            y:rect.origin.y))
        
        gridPath.addLine(to: CGPoint(
            x:rect.origin.x + ( fraction * rect.size.width),
            y:rect.origin.y + rect.size.height))
        }
        
        _ = ( 0 ... rows).map {
            let fraction = CGFloat($0) / CGFloat(rows)
            gridPath.move(to: CGPoint(x: rect.origin.x,
                                      y: rect.origin.y + fraction * rect.size.height))
            gridPath.addLine(to: CGPoint(x: rect.origin.x + rect.size.height,
                                         y:rect.origin.y + fraction * rect.size.height))
        }
        
        let cellSize = CGSize(width: rect.size.width/CGFloat(cols),
                              height: rect.size.height/CGFloat(rows))
        for  i in 0 ..< cols {
            for  j in 0 ..< rows {
                let colFraction = CGFloat(i)/CGFloat(cols)
                let rowFraction = CGFloat(j)/CGFloat(rows)
                let cellOrigin = CGPoint(x:rect.origin.x + (colFraction*rect.size.width),
                    y:rect.origin.y + (rowFraction*rect.size.height))
                let cell = CGRect(origin: cellOrigin, size: cellSize)
                let path = UIBezierPath(ovalIn: cell)
                cellColor.setFill()
                path.fill()
            }
        }
        
        //draw the stroke
        gridColor.setStroke()
        gridPath.stroke()
    }
}
