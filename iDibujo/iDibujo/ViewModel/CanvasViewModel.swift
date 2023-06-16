//
//  CanvasViewModel.swift
//  iDibujo
//
//  Created by Israel Manzo on 8/13/21.
//  Copyright © 2021 Israel Manzo. All rights reserved.
//

import UIKit

protocol CanvasViewModelProtocol {
    func eraseCanvas(eraserButton: UIButton)
    func colorPicker(_ sender: UISlider)
    func draw(from: CGPoint, to: CGPoint)
}

class CanvasViewModel: CanvasViewModelProtocol {
    
    var draw = Draw()
    
    // MARK: - Erase button re assigning values to delete stroke + switch title.
    func eraseCanvas(eraserButton: UIButton) {
        
        let fontLarge = UIFont.systemFont(ofSize: 30)
        let config = UIImage.SymbolConfiguration(font: fontLarge)
        var image: UIImage!
        
        if draw.isDrawing {
            (draw.red, draw.green, draw.blue) = (1, 1, 1)
            image = UIImage(systemName: CustomIcon.hand_draw, withConfiguration: config)
            eraserButton.setImage(image, for: .normal)
        } else {
            (draw.red, draw.green, draw.blue) = (0, 0, 0)
            image = UIImage(systemName: CustomIcon.ereaser, withConfiguration: config)
            eraserButton.setImage(image, for: .normal)
        }
        draw.isDrawing = !draw.isDrawing
    }
    
    // MARK: - Selected by tag number and re assigning values to the pointer/brush.
    func colorPicker(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            (draw.red, draw.green, draw.blue) = (1, 0, 0)
        case 1:
            (draw.red, draw.green, draw.blue) = (0, 1, 0)
        case 2:
            (draw.red, draw.green, draw.blue) = (0, 0, 1)
        case 3:
            (draw.red, draw.green, draw.blue) = (1, 0, 1)
        case 4:
            (draw.red, draw.green, draw.blue) = (1, 1, 0)
        case 5:
            (draw.red, draw.green, draw.blue) = (0, 1, 1)
        case 6:
            (draw.red, draw.green, draw.blue) = (1, 1, 1)
        case 7:
            (draw.red, draw.green, draw.blue) = (0, 0, 0)
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
        guard let context = UIGraphicsGetCurrentContext() else { return }
        // move the pointer method from x to y
        context.move(to: CGPoint(x: from.x, y: from.y))
        // add line to the context when x and y moves
        context.addLine(to: CGPoint(x: to.x, y: to.y))
        
        context.setBlendMode(.normal)
        context.setLineCap(CGLineCap.round) // give round to the line
        context.setLineWidth(draw.brushSize) // Brush size variable value
        context.setStrokeColor(UIColor(red: draw.red, green: draw.green, blue: draw.blue, alpha: draw.opacity).cgColor) // set stroke to the context pointer
        context.strokePath() // set path to the context pointer
        
        draw.container.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // ends graphic context
    }
    
    
}
