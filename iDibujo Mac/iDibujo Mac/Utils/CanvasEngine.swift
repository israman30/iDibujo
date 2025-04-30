//
//  CanvasEngine.swift
//  iDibujo Mac
//
//  Created by Israel Manzo on 4/29/25.
//

import SwiftUI

class CanvasEngine {
    func createPath(for points: [CGPoint]) -> Path {
        .init { path in
            path.move(to: points[0])
            for point in points[1...] {
                path.addLine(to: point)
            }
        }
    }
}
