//
//  BrushType.swift
//  iDibujo
//
//  Created by Israel Manzo on 3/2/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI

/// Brush types with distinct visual characteristics for drawing.
enum BrushType: String, CaseIterable, Identifiable {
    case pencil
    case marker
    case paintbrush
    case highlighter
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .pencil: return "pencil"
        case .marker: return "paintbrush"
        case .paintbrush: return "paintbrush.fill"
        case .highlighter: return "highlighter"
        }
    }
    
    var label: String {
        switch self {
        case .pencil: return "Pencil"
        case .marker: return "Marker"
        case .paintbrush: return "Paint"
        case .highlighter: return "Highlight"
        }
    }
}
