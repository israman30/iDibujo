//
//  SettingsViewModel.swift
//  iDibujo
//
//  Created by Israel Manzo on 2/24/23.
//  Copyright © 2023 Israel Manzo. All rights reserved.
//

import UIKit

class SettingsViewModel {
    
    var draw = Draw()
    
    func preview(with imageView: UIImageView) {
        // Get context
        let context = UIGraphicsGetCurrentContext()
        // Set stroke color for context
        context?.setStrokeColor(UIColor(red: draw.red, green: draw.green, blue: draw.blue, alpha: draw.opacity).cgColor)
        context?.setLineWidth(draw.brushSize) // Line width context
        context?.setLineCap(CGLineCap.round) // Round line context
        context?.move(to: CGPoint(x: 70, y: 70)) // Move points x to y
        context?.addLine(to: CGPoint(x: 70, y: 70)) // Add line to x and y
        context?.strokePath() // Set stroke line
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // End context
    }
    
    func blueColor(_ sender: UISlider, blueLabel: UILabel) {
        draw.blue = CGFloat(sender.value)
        blueLabel.text = "\(Int(sender.value * 255))"
    }
}
