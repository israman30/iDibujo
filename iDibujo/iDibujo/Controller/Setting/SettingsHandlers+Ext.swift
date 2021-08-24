//
//  SettingsHandlers+Ext.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/24/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension SettingsController {
    
    @objc func back() {
        if delegate != nil {
            delegate?.settingsDidFinish(self)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleBlueColor(_ sender: UISlider) {
        blue = CGFloat(sender.value)
        previewDraw(red: red, green: green, blue: blue)
        blueLabel.text = "\(Int(sender.value * 255))"
    }
    
    @objc func handleGreenColor(_ sender: UISlider) {
        green = CGFloat(sender.value)
        previewDraw(red: red, green: green, blue: blue)
        greenLabel.text = "\(Int(sender.value * 255))"
    }
    
    @objc func handleRedColor(_ sender: UISlider){
        red = CGFloat(sender.value)
        previewDraw(red: red, green: green, blue: blue)
        redLabel.text = "\(Int(sender.value * 255))"
    }
    
    @objc func handleChangeOpacitySize(_ sender: UISlider) {
        opacity = CGFloat(sender.value)
        previewDraw(red: red, green: green, blue: blue)
    }
    
    @objc func handleChangeBrushSize(_ sender: UISlider){
        brushSize1 = CGFloat(sender.value)
        previewDraw(red: red, green: green, blue: blue)
    }
    
}
// TODO: Comple the viewmodel
class SettingsViewModel {
    var red: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var green: CGFloat = 0.0
    
    var brushSize1: CGFloat = 5.0
    
    var opacity: CGFloat = 1.0
    
    func preview(with imageView: UIImageView) {
        // Get context
        let context = UIGraphicsGetCurrentContext()
        // Set stroke color for context
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: opacity).cgColor)
        context?.setLineWidth(brushSize1) // Line width context
        context?.setLineCap(CGLineCap.round) // Round line context
        context?.move(to: CGPoint(x: 70, y: 70)) // Move points x to y
        context?.addLine(to: CGPoint(x: 70, y: 70)) // Add line to x and y
        context?.strokePath() // Set stroke line
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // End context
    }
    
    func blueColor(_ sender: UISlider, blueLabel: UILabel) {
        blue = CGFloat(sender.value)
        blueLabel.text = "\(Int(sender.value * 255))"
    }
}
