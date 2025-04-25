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
    
    var body: some View {
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
                    lines.append(Line(points: [newPoint], color: .blue, width: 5))
                } else {
                    let index = lines.count - 1
                    lines[index].points.append(newPoint)
                }
            })
        )
    }
}
