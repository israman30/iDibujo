//
//  CanvasView.swift
//  iDibujo
//
//  Created by Israel Manzo on 6/16/24.
//  Copyright © 2024 Israel Manzo. All rights reserved.
//

import SwiftUI

/// MARK: - `CanvasView` renders the dashboard or canvas where users can draw using gestures.
/// - Parameters:
///   - lines: array of `Line` to store each point of the gesture
///   - selectedColor: reference for adding a new color to the array
///   - newValue: array that soter the line with CGFloat value
struct CanvasView: View {
    @Binding var lines: [Line]
    @Binding var selectedColor: Color
    @Binding var deletedLines: [Line]
    @State var vm: LineViewModel
    @State var newValue: [CGFloat] = []
    let canvas = CanvasEnginer()
    
    var body: some View {
        Canvas { context, size in
            lines.forEach { line in
                let path = canvas.createPath(for: line.points)
                context.stroke(
                    path,
                    with: .color(line.color),
                    style: StrokeStyle(lineWidth: line.width, lineCap: .round, lineJoin: .round)
                )
            }
        } // minimunDistance is the initial point when the line starts
        .gesture(
            DragGesture(
                minimumDistance: 0,
                coordinateSpace: .local
            )
            .onChanged({ value in
                let position = value.location
                // if no value has found/no line append a new start to create line
                if value.translation.width + value.translation.height == .zero {
                    lines.append(
                        Line(
                            points: [position],
                            color: selectedColor,
                            width: vm.lineWithValue
                        )
                    )
                } else { // otherwise append to last point to create a line
                    guard let lastIndex = lines.indices.last else { return }
                    lines[lastIndex].points.append(position)
                }
            })
            .onEnded({ value in
                if let lastLine = lines.last?.points, lastLine.isEmpty {
                    lines.removeLast()
                }
            })
        )
    }
}

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

// MARK: - The extension provides a method to capture a snapshot of the displayed element or the view itself.
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
