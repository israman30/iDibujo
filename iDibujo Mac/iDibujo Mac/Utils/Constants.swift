//
//  Constants.swift
//  iDibujo Mac
//
//  Created by Israel Manzo on 4/30/25.
//
import Foundation

struct CustomIcon {
    static let tray_and_arrow_down = "tray.and.arrow.down"
    static let trash_square = "trash.square"
    static let hand_draw = "hand.draw"
    static let eraser = "eraser"
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
    static let colorPicker = NSLocalizedString("Color Picker", comment: "Color picker accessibility label")
    static let save = NSLocalizedString("Save Canvas", comment: "Save canvas menu item")
    static let back = NSLocalizedString("Back", comment: "Back to canvas")
    static let clearCanvas = NSLocalizedString("Clear Canvas", comment: "Clear canvas menu item")
    static let canvasSaved = NSLocalizedString("Canvas Saved!", comment: "Toast when canvas is saved")
}
