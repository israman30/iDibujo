//
//  Drawing+Ext.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/24/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension MainController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swipe = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    /* MARK: - Draw function
     1.- UIGraphicImageContext covers the imageView container/surface where draws.
     2.- Context from UIGraphicCurrentContext assign two points, to - from and addLine assing a value for those points.
     3.- Context setLineStroke takes a CGFloat value as a line.
     4.- Context setStrokeColor takes UIColor.cgColor.
     5.- Context set the path.
     6.- Then ends with image context.
     */
    func drawnLine(from: CGPoint, to: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        container.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: from.x, y: from.y))
        context?.addLine(to: CGPoint(x: to.x, y: to.y))
        
        context?.setBlendMode(.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushSize) // Brush size variable value
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: opacity).cgColor)
        context?.strokePath()
        
        container.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swipe = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.view)
            drawnLine(from: lastPoint , to: currentPoint)
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swipe {
            drawnLine(from: lastPoint, to: lastPoint)
        }
    }
}