//
//  PreviewDraw+Ext.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/24/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension SettingsController {
    
    // MARK: - PREVIEW DRAWING
    func previewDraw(red: CGFloat, green: CGFloat, blue: CGFloat) {
        // Assign imageView to the graphic conext
        UIGraphicsBeginImageContext(imageView.frame.size)
        // Get context
        let context = UIGraphicsGetCurrentContext()
        // Set stroke color for context
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: settingsViewModel.draw.opacity).cgColor)
        context?.setLineWidth(settingsViewModel.draw.brushSize) // Line width context
        context?.setLineCap(CGLineCap.round) // Round line context
        context?.move(to: CGPoint(x: 70, y: 70)) // Move points x to y
        context?.addLine(to: CGPoint(x: 70, y: 70)) // Add line to x and y
        context?.strokePath() // Set stroke line
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // End context
    }
}
