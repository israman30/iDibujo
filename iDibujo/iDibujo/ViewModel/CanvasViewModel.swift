//
//  CanvasViewModel.swift
//  iDibujo
//
//  Created by Israel Manzo on 8/13/21.
//  Copyright © 2021 Israel Manzo. All rights reserved.
//

import UIKit

class CanvasViewModel {
    
    let container = UIImageView()
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    var lastPoint = CGPoint.zero
    var swipe = false
    
    var brushSize: CGFloat = 9.0
    
    var opacity: CGFloat = 1.0
    
    var isDrawing = true
    
    // MARK: - Erase button re assigning values to delete stroke + switch title.
    func eraseCanvas(eraserButton: UIButton) {
        if isDrawing {
            (red, green, blue) = (1, 1, 1)
            eraserButton.setTitle("DRAW", for: .normal)
        } else {
            (red, green, blue) = (0, 0, 0)
            eraserButton.setTitle("DELT", for: .normal)
        }
        isDrawing = !isDrawing
    }
    
    // MARK: - Selected by tag number and re assigning values to the pointer/brush.
    func colorPicker(_ sender: UISlider) {
        switch sender.tag {
            case 0:
                (red, green, blue) = (1, 0, 0)
            case 1:
                (red, green, blue) = (0, 1, 0)
            case 2:
                (red, green, blue) = (0, 0, 1)
            case 3:
                (red, green, blue) = (1, 0, 1)
            case 4:
                (red, green, blue) = (1, 1, 0)
            case 5:
                (red, green, blue) = (0, 1, 1)
            case 6:
                (red, green, blue) = (1, 1, 1)
            case 7:
                (red, green, blue) = (0, 0, 0)
            default:
                break
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
    func draw(from: CGPoint, to: CGPoint) {
        // Get current graphic context
        let context = UIGraphicsGetCurrentContext()
        // move the pointer method from x to y
        context?.move(to: CGPoint(x: from.x, y: from.y))
        // add line to the context when x and y moves
        context?.addLine(to: CGPoint(x: to.x, y: to.y))
        
        context?.setBlendMode(.normal)
        context?.setLineCap(CGLineCap.round) // give round to the line
        context?.setLineWidth(brushSize) // Brush size variable value
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: opacity).cgColor) // set stroke to the context pointer
        context?.strokePath() // set path to the context pointer
        
        container.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // ends graphic context
    }
    
    
}
