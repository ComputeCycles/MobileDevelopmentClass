//
//  GridView.swift
//  Lecture8
//
//  Created by Van Simmons on 10/3/16.
//  Copyright © 2016 ComputeCycles, LLC. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    
    @IBInspectable var rows: Int = 4 {
        didSet {
            grid = Grid(rows: self.rows, cols: self.cols)
        }
    }
    @IBInspectable var cols: Int = 4 {
        didSet {
            grid = Grid(rows: self.rows, cols: self.cols)
        }
    }
    @IBInspectable var cellColor = UIColor.yellow
    @IBInspectable var gridColor = UIColor.cyan
    
    var grid: Grid!

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
                let gridCell = grid[j,i]
                var fillColor = UIColor.clear
                if gridCell!.state.isAlive() {
                    fillColor = cellColor
                }
                fillColor.setFill()
                path.fill()
            }
        }
        
        //draw the stroke
        gridColor.setStroke()
        gridPath.stroke()
    }
    
    func process(touches: Set<UITouch>) {
        _ = touches.map {
            convert(touch:$0)
            }
            .map {
                if grid[$0.row, $0.col]!.state.isAlive() {
                    grid[$0.row,$0.col]!.state = .Empty
                }
                else {
                    grid[$0.row,$0.col]!.state = .Alive
                }
        }
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        process(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        process(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        process(touches: touches)
    }
    
    typealias Position = (row: Int, col: Int)
    func convert(touch: UITouch) -> Position {
        let touchY = touch.location(in: self).y
        let gridHeight = frame.size.height
        let row = touchY / gridHeight * CGFloat(rows)
        let touchX = touch.location(in: self).x
        let gridWidth = frame.size.width
        let col = touchX / gridWidth * CGFloat(cols)
        let position = (row: Int(row), col: Int(col))
        return position
    }
}
