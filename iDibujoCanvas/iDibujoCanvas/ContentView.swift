//
//  ContentView.swift
//  iDibujoCanvas
//
//  Created by Israel Manzo on 4/25/25.
//

import SwiftUI

struct Line {
    var points: [CGPoint]
    var color: Color
    var width: CGFloat
}

struct ContentView: View {
    var body: some View {
        CanvasView()
    }
}

#Preview {
    ContentView()
}

struct CanvasView: View {
    
    @State private var lines = [Line]()
    @State private var selectedColor: Color = .black
    @State private var selectedWidth: CGFloat = 1
    
    var body: some View {
        VStack {
            ColorPicker("line color", selection: $selectedColor)
            Slider(value: $selectedWidth, in: 1...10) {
                Text("line width: \($selectedWidth)")
            }
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    
                    context.stroke(path, with: .color(line.color), lineWidth: line.width)
                }
            }
            .gesture(
                DragGesture(
                    minimumDistance: 0,
                    coordinateSpace: .local
                ).onChanged({ value in
                        let newPoint = value.location
                        if value.translation.width + value.translation.height == 0 {
                            // TODO: implement color
                            lines.append(
                                Line(points: [newPoint], color: selectedColor, width: selectedWidth)
                            )
                    } else {
                        let index = lines.count - 1
                        lines[index].points.append(newPoint)
                    }
                })
            )
        }
    }
}
