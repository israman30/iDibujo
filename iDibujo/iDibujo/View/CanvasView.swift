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
    @State var vm: LineViewModel
    @State var newValue: [CGFloat] = []
    
    var body: some View {
        Canvas { context, size in
            lines.forEach {
                var path = Path()
                DispatchQueue.main.async {
                    self.newValue.append(vm.lineWithValue)
                }
                path.addLines($0.points)
                let strokeStyle = StrokeStyle(lineWidth: vm.lineWithValue, lineCap: .round, lineJoin: .round)
                context.stroke(path, with: .color($0.color), style: strokeStyle)
            }
        } // minimunDistance is the initial point when the line starts
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ value in
                    let position = value.location
                    // if no value has found/no line append a new start to create line
                    if value.translation == .zero {
                        lines.append(Line(points: [position], color: selectedColor))
                    } else { // otherwise append to last point to create a line
                        guard let lastIndex = lines.indices.last else { return }
                        lines[lastIndex].points.append(position)
                    }
                })
        )
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
