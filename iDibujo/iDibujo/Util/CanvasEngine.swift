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
}
