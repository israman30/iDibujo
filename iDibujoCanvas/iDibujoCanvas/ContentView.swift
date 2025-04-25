//
//  ContentView.swift
//  iDibujoCanvas
//
//  Created by Israel Manzo on 4/25/25.
//

import SwiftUI

struct Line: Identifiable {
    var id = UUID()
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
    @State private var deletedLines: [Line] = []
    @State private var selectedColor: Color = .black
    @State private var selectedWidth: CGFloat = 1
    @State private var showDialog: Bool = false
    
    let canvas = CanvasEnginer()
    
    var body: some View {
        VStack {
            VStack {
                ColorPicker("line color", selection: $selectedColor)
                HStack {
                    Button("undo") {
                        let last = lines.removeLast()
                        deletedLines.append(last)
                    }
                    .disabled(lines.count == 0)
                    
                    Button("Delete") {
                        showDialog = true
                    }
                    .confirmationDialog("Delete..?", isPresented: $showDialog) {
                        Button("Delete", role: .destructive) {
                            lines = []
                            deletedLines = []
                        }
                    }
                    
                    Button("redo") {
                        let last = deletedLines.removeLast()
                        lines.append(last)
                    }
                    .disabled(deletedLines.count == 0)
                }
                HStack {
                    Slider(value: $selectedWidth, in: 1...20) {
                        Text("line width: \($selectedWidth)")
                    }
                    Text(String(format: "%.0f",selectedWidth))
                }
            }
            .padding(.horizontal)
            
            Canvas { context, size in
                for line in lines {
                    let path = canvas.createPath(for: line.points)
                    context.stroke(path, with: .color(line.color), style: StrokeStyle(lineWidth: line.width, lineCap: .round, lineJoin: .round))
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
                .onEnded({ value in
                    if let lastLine = lines.last?.points, lastLine.isEmpty {
                        lines.removeLast()
                    }
                })
            )
        }
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

// MARK: - These component are for lower version of iOS devices less than iOS 15
struct CanvasLowetVersion: View {
    var lines: [Line]
    var body: some View {
        ZStack {
            Color.white
            ForEach(lines) { line in
                DrawingShape(points: line.points)
                    .stroke(line.color, style: StrokeStyle(lineWidth: line.width, lineCap: .round, lineJoin: .round))
            }
        }
    }
}

struct DrawingShape: Shape {
    let points: [CGPoint]
    var canvas = CanvasEnginer()
    
    func path(in rect: CGRect) -> Path {
        canvas.createPath(for: points)
    }
}
