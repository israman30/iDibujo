//
//  MainHandlers+Ext.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/24/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension MainController {
    
    // MARK: - Reset Main draw view.
    // AlerController class check if user wants to reset the draw.
    @objc func reset() {
        AlertController.resetDraw(self, imageView: canvasViewModel.draw.container)
    }
    
    // MARK: - Handles when user saves a draw in the local photo gallery library.
    @objc func handleImport() {
        savePhotoToLibrary()
    }
    
    /*
     MARK: - Present SettingsController
           - Handles the delegation of SettingController to the MainController, passing the values that the user changed using slider values.
     */
    @objc func setting() {
        let settingsController = SettingsController()
        settingsController.delegate = self
        settingsController.settingsViewModel.draw.red = canvasViewModel.draw.red
        settingsController.settingsViewModel.draw.blue = canvasViewModel.draw.blue
        settingsController.settingsViewModel.draw.green = canvasViewModel.draw.green
        settingsController.settingsViewModel.draw.brushSize = canvasViewModel.draw.brushSize
        settingsController.settingsViewModel.draw.opacity = canvasViewModel.draw.opacity
        present(settingsController, animated: true, completion: nil)
    }
    
    // MARK: - Handles when user tap on erase button re assigning values to delete stroke + switch title.
    @objc func erase() {
        canvasViewModel.eraseCanvas(eraserButton: eraserButton)
    }
    
    // MARK: - Handlers when user tap on a color button, selected by tag number and re assigning values to the pointer/brush.
    @objc func pickColorHandler(_ sender: UISlider) {
        canvasViewModel.colorPicker(sender)
    }
    
}

