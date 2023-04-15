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
        settingsViewModel.draw.blue = CGFloat(sender.value)
        previewDraw(red: settingsViewModel.draw.red, green: settingsViewModel.draw.green, blue: settingsViewModel.draw.blue)
        blueLabel.text = "\(Int(sender.value * 255))"
    }
    
    @objc func handleGreenColor(_ sender: UISlider) {
        settingsViewModel.draw.green = CGFloat(sender.value)
        previewDraw(red: settingsViewModel.draw.red, green: settingsViewModel.draw.green, blue: settingsViewModel.draw.blue)
        greenLabel.text = "\(Int(sender.value * 255))"
    }
    
    @objc func handleRedColor(_ sender: UISlider){
        settingsViewModel.draw.red = CGFloat(sender.value)
        previewDraw(red: settingsViewModel.draw.red, green: settingsViewModel.draw.green, blue: settingsViewModel.draw.blue)
        redLabel.text = "\(Int(sender.value * 255))"
    }
    
    @objc func handleChangeOpacitySize(_ sender: UISlider) {
        settingsViewModel.draw.opacity = CGFloat(sender.value)
        previewDraw(red: settingsViewModel.draw.red, green: settingsViewModel.draw.green, blue: settingsViewModel.draw.blue)
    }
    
    @objc func handleChangeBrushSize(_ sender: UISlider) {
        settingsViewModel.draw.brushSize = CGFloat(sender.value)
        previewDraw(red: settingsViewModel.draw.red, green: settingsViewModel.draw.green, blue: settingsViewModel.draw.blue)
    }
    
    @objc func closeView() {
        dismiss(animated: true)
    }
    
}

