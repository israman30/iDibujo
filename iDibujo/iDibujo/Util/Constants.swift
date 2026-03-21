//
//  Constants.swift
//  iDibujo
//
//  Created by Israel Manzo on 4/20/23.
//  Copyright © 2023 Israel Manzo. All rights reserved.
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
    static let resetZoom = "arrow.up.left.and.arrow.down.right"
}

struct Labels {
    static let colorPicker = NSLocalizedString("Color Picker", comment: "Color picker accessibility label")
    static let save = NSLocalizedString("Save Canvas", comment: "Save canvas menu item")
    static let back = NSLocalizedString("Back", comment: "Back to canvas")
    static let clearCanvas = NSLocalizedString("Clear Canvas", comment: "Clear canvas menu item")
    static let canvasSaved = NSLocalizedString("Canvas Saved!", comment: "Toast when canvas is saved")
    static let background = NSLocalizedString("Background", comment: "Canvas background")
    static let backgroundWhite = NSLocalizedString("White", comment: "White background option")
    static let backgroundBlack = NSLocalizedString("Black", comment: "Black background option")
    static let backgroundGrid = NSLocalizedString("Grid", comment: "Grid background option")
    static let backgroundLined = NSLocalizedString("Lined Paper", comment: "Lined paper background option")
    static let backgroundCustom = NSLocalizedString("Custom Image", comment: "Custom image background option")
    static let resetZoom = NSLocalizedString("Reset Zoom", comment: "Reset zoom")
    
    // MARK: - Accessibility
    static let a11yDrawingCanvas = NSLocalizedString("Drawing canvas", comment: "Accessibility label for drawing canvas")
    static let a11yDrawingCanvasHint = NSLocalizedString("Draw with one finger. Two-finger tap to undo, three-finger tap to redo.", comment: "Accessibility hint for drawing canvas")
    static let a11yColorSelected = NSLocalizedString("Selected", comment: "Selected color accessibility")
    static let a11ySelectColor = NSLocalizedString("Select color", comment: "Select color accessibility")
    static let a11yMenuHint = NSLocalizedString("Opens menu with clear, back, and save options", comment: "Menu accessibility hint")
    static let a11yUndo = NSLocalizedString("Undo", comment: "Undo button")
    static let a11yUndoHint = NSLocalizedString("Undo last stroke", comment: "Undo accessibility hint")
    static let a11yRedo = NSLocalizedString("Redo", comment: "Redo button")
    static let a11yRedoHint = NSLocalizedString("Redo last undone stroke", comment: "Redo accessibility hint")
    static let a11yLineWidth = NSLocalizedString("Line width", comment: "Line width slider")
    static let a11yLineWidthHint = NSLocalizedString("Adjust stroke thickness. Swipe up or down to change.", comment: "Line width accessibility hint")
    static let a11yBrushPickerHint = NSLocalizedString("Choose brush type", comment: "Brush picker accessibility hint")
    static let a11yBackgroundPickerHint = NSLocalizedString("Choose canvas background", comment: "Background picker accessibility hint")
}

/// Canvas background style options
enum CanvasBackgroundType: String, CaseIterable, Identifiable {
    case white
    case black
    case grid
    case linedPaper
    case customImage
    
    var id: String { rawValue }
    
    var label: String {
        switch self {
        case .white: return Labels.backgroundWhite
        case .black: return Labels.backgroundBlack
        case .grid: return Labels.backgroundGrid
        case .linedPaper: return Labels.backgroundLined
        case .customImage: return Labels.backgroundCustom
        }
    }
    
    var icon: String {
        switch self {
        case .white: return "square.fill"
        case .black: return "square"
        case .grid: return "square.grid.3x3"
        case .linedPaper: return "line.3.horizontal"
        case .customImage: return "photo"
        }
    }
}
