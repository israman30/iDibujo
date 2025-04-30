//
//  Constants.swift
//  iDibujo Mac
//
//  Created by Israel Manzo on 4/30/25.
//

import UIKit
import SwiftUI

struct CustomColor {
    static let blackColor = UIColor(Color(.label))
    static let blackPrimary = UIColor.black
    static let blackSecondary = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1)
    
    static let redPrimary = UIColor.red
    static let redSecondary = UIColor(red: 178/255, green: 34/255, blue: 34/255, alpha: 1)
    
    static let greenPrimary = UIColor.green
    static let greenSecondary = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)
    
    static let bluePrimary = UIColor.blue
    static let blueSecondary = UIColor(red: 0/255, green: 0/255, blue: 125/255, alpha: 1)
}

struct CustomIcon {
    static let tray_and_arrow_down = "tray.and.arrow.down"
    static let trash_square = "trash.square"
    static let hand_draw = "hand.draw"
    static let eraser = "eraser.line.dashed"
    static let scribble_variable = "scribble.variable"
    static let xmark_square = "xmark.square"
    
    static let circleFill = "circle.fill"
    static let backToCanvas = "arrowshape.backward"
    static let pencil = "pencil.tip.crop.circle.badge.arrow.forward"
    static let saveCanvas = "tray.and.arrow.down"
    
    static let undo = "arrow.clockwise"
    static let redo = "arrow.counterclockwise"
}

struct Labels {
    static let colorPicker = "Color Picker"
    static let save = "Save Canvas"
    static let back = "Back"
    static let clearCanvas = "Clear Canvas"
    static let canvasSaved = "Canvas Saved!"
}
