//
//  MainHandlers+Ext.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/24/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension MainController {
    
    @objc func reset() {
        container.image = nil
    }
    
    @objc func handleImport(){
        savePhotoToLibrary()
    }
    
    @objc func image(_ image: UIImage, didFinishWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error {
            AlertController.alert(self, title: "Error", message: error.localizedDescription)
        } else {
            AlertController.alert(self, title: "Saved", message: "You photo has been saved!")
        }
    }
    
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
    
    @objc func erase(){
        if isDrawing {
            (red, green, blue) = (1, 1, 1)
            eraserButton.setTitle("DRAW", for: .normal)
        } else {
            (red, green, blue) = (0, 0, 0)
            eraserButton.setTitle("ERASE", for: .normal)
        }
        isDrawing = !isDrawing
    }
    
    @objc func foo(){
        print("foo")
    }
    
    @objc func handleDraw(_ sender: UISlider){
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
