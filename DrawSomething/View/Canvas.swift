//
//  Canvas.swift
//  DrawSomething
//
//  Created by Wilfred Furthado M on 21/03/19.
//  Copyright © 2019 Pervacio. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    var lines = [Line]()
    
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 1

    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //To draw lines
        
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.butt)

            for (i,p) in line.point.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(color: strokeColor, strokeWidth: strokeWidth, point: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else {
            return
        }
        
        lastLine.point.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }

}
