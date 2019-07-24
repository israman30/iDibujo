//
//  MainDelegate+Ext.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/24/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension MainController: SettingsDelagate {
    
    func settingsDidFinish(_ settings: SettingsController) {
        self.red = settings.red
        self.blue = settings.blue
        self.green = settings.green
        self.brushSize = settings.brushSize1
        self.opacity = settings.opacity
    }
    
}

