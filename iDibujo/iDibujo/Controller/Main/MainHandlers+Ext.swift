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
    @objc func reset() {
        container.image = nil
    }
    
    // MARK: - Handles when user saves a draw in the local photo gallery library.
    @objc func handleImport(){
        savePhotoToLibrary()
    }
    
    /*
     MARK: - Present SettingsController
           - Handles the delegation of SettingController to the MainController, passing the values that the user changed using slider values.
     */
    @objc func setting(){
        let settingsController = SettingsController()
        settingsController.delegate = self
        settingsController.red = red
        settingsController.blue = blue
        settingsController.green = green
        settingsController.brushSize1 = brushSize
        settingsController.opacity = opacity
        present(settingsController, animated: true, completion: nil)
    }
    
    // MARK: - Handles when user tap on erase button re assigning values to delete stroke + switch title.
    @objc func erase() {
        if isDrawing {
            (red, green, blue) = (1, 1, 1)
            eraserButton.setTitle("DRAW", for: .normal)
        } else {
            (red, green, blue) = (0, 0, 0)
            eraserButton.setTitle("ERASE", for: .normal)
        }
        isDrawing = !isDrawing
    }
    
    // MARK: - Handlers when user tap on a color button, selected by tag number and re assigning values to the pointer/brush.
    @objc func pickColorHandler(_ sender: UISlider){
        if sender.tag == 0 {
            (red, green, blue) = (1, 0, 0)
        } else if sender.tag == 1 {
            (red, green, blue) = (0, 1, 0)
        } else if sender .tag == 2 {
            (red, green, blue) = (0, 0, 1)
        } else if sender.tag == 3 {
            (red, green, blue) = (1, 0, 1)
        } else if  sender.tag == 4 {
            (red, green, blue) = (1, 1, 0)
        } else if sender.tag == 5 {
            (red, green, blue) = (0, 1, 1)
        } else if sender.tag == 6 {
            (red, green, blue) = (1, 1, 1)
        } else if sender.tag == 7 {
            (red, green, blue) = (0, 0, 0)
        }
        
    }
    
}
