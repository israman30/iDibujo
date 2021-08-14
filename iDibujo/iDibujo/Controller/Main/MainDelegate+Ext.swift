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
extension MainController: SettingsDelagate {
    
    func settingsDidFinish(_ settings: SettingsController) {
        self.canvasViewModel.red = settings.red
        self.canvasViewModel.blue = settings.blue
        self.canvasViewModel.green = settings.green
        self.canvasViewModel.brushSize = settings.brushSize1
        self.canvasViewModel.opacity = settings.opacity
    }
    
}

