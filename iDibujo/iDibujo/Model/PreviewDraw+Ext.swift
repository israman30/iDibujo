//
//  PreviewDraw+Ext.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/24/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension SettingsController {
    
    // MARK: Preview drawing function
    func previewDraw(red: CGFloat, green: CGFloat, blue: CGFloat){
        UIGraphicsBeginImageContext(imageView.frame.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: opacity).cgColor)
        context?.setLineWidth(brushSize1)
        context?.setLineCap(CGLineCap.round)
        context?.move(to: CGPoint(x: 70, y: 70))
        context?.addLine(to: CGPoint(x: 70, y: 70))
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
