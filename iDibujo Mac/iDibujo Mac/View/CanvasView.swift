//
//  CanvasView.swift
//  iDibujo Mac
//
//  Created by Israel Manzo on 4/30/25.
//

import SwiftUI

struct CanvasView: View {
    @Binding var lines: [Line]
    @Binding var selectedColor: Color
    @Binding var deletedLines: [Line]
    @State var vm: LineViewModel
    @State var newValue: [CGFloat] = []
    let canvas = CanvasEngine()
    
    var body: some View {
        Canvas { context, size in
            lines.forEach { line in
                let path = canvas.createPath(for: line.points)
                context.stroke(path, with: .color(line.color), style: StrokeStyle(lineWidth: line.lineWidth, lineCap: .round, lineJoin: .round))
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ value in
                    let position = value.location
                    if value.translation.width + value.translation.height == .zero {
                        lines.append(
                            Line(points: [position], color: selectedColor, lineWidth: vm.lineWithValue)
                        )
                    } else {
                        guard let lastLineIndex = lines.indices.last else { return }
                        lines[lastLineIndex].points.append(position)
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
