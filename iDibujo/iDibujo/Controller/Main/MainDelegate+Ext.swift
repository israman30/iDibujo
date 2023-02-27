//
//  MainDelegate+Ext.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/24/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit
/*
 MARK: - Handles MainController delegation
 - Handles the delegation of SettingController to the MainController, passing the values that the user changed using slider values.
 */
extension MainController: SettingsProtocol {
    
    func settingsDidFinish(_ settings: SettingsController) {
        canvasViewModel.draw.red = settings.settingsViewModel.draw.red
        canvasViewModel.draw.blue = settings.settingsViewModel.draw.blue
        canvasViewModel.draw.green = settings.settingsViewModel.draw.green
        canvasViewModel.draw.brushSize = settings.settingsViewModel.draw.brushSize
        canvasViewModel.draw.opacity = settings.settingsViewModel.draw.opacity
    }
    
}

