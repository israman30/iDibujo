//
//  SettingsHandlers+Ext.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/24/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension SettingsController {
    
    @objc func back(){
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
