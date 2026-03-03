//
//  CanvasEngine.swift
//  iDibujo
//
//  Created by Israel Manzo on 4/26/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI

class CanvasEnginer {
    func createPath(for points: [CGPoint]) -> Path {
        var path = Path()
        path.move(to: points[0])
        for point in points[1...] {
            path.addLine(to: point)
        }
        return path
    }
    
    func calculate(_ point1: CGPoint, point2: CGPoint) -> CGPoint {
        CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
    }
    
    /// Renders a line with the appropriate style for its brush type.
    func stroke(_ path: Path, line: Line, in context: inout GraphicsContext) {
        guard line.points.count > 1 else { return }
        
        let baseStyle = StrokeStyle(lineWidth: line.width, lineCap: .round, lineJoin: .round)
        
        switch line.brushType {
        case .pencil:
            // Low opacity, subtle dash for pencil texture
            context.opacity = 0.65
            context.stroke(
                path,
                with: .color(line.color),
                style: StrokeStyle(
                    lineWidth: line.width * 0.9,
                    lineCap: .round,
                    lineJoin: .round,
                    dash: [1, 2],
                    dashPhase: 0
                )
            )
            context.opacity = 1.0
            
        case .marker:
            // Solid, smooth — default crisp stroke
            context.stroke(path, with: .color(line.color), style: baseStyle)
            
        case .paintbrush:
            // Pressure-style: layered strokes for soft, organic feel
            let layers = 3
            for i in (0..<layers).reversed() {
                let layerOpacity = 0.35 + Double(i) * 0.25
                let layerWidth = line.width * (1.2 + CGFloat(i) * 0.15)
                context.opacity = layerOpacity
                context.stroke(
                    path,
                    with: .color(line.color),
                    style: StrokeStyle(lineWidth: layerWidth, lineCap: .round, lineJoin: .round)
                )
            }
            context.opacity = 1.0
            
        case .highlighter:
            // Blend mode for transparent highlight effect
            context.blendMode = .plusLighter
            context.opacity = 0.45
            context.stroke(
                path,
                with: .color(line.color),
                style: StrokeStyle(lineWidth: line.width * 1.8, lineCap: .round, lineJoin: .round)
            )
            context.opacity = 1.0
            context.blendMode = .normal
        }
    }
}
