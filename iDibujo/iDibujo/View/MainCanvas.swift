//
//  MainCanvas.swift
//  iDibujo
//
//  Created by Israel Manzo on 6/15/24.
//  Copyright © 2024 Israel Manzo. All rights reserved.
//

import SwiftUI

struct Line {
    var points: [CGPoint]
    var color: Color
}

struct MainCanvas: View {
    
    @State private var lines = [Line]()
    @State private var selectedColor = Color.black
    @State private var colors: [Color] = [.green, .orange, .blue, .red, .pink, .black, .purple]
    
    var body: some View {
        VStack {
            HStack {
                ForEach(colors, id: \.self) { color in
                    colorButton(color: color)
                }
                clearButton()
            }
            Canvas { context, size in
                lines.forEach {
                    var path = Path()
                    path.addLines($0.points)
                    
                    let strokeStyle = StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round)
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
    
    @ViewBuilder
    func colorButton(color: Color) -> some View {
        Button {
            selectedColor = color
        } label: {
            Image(systemName: "circle.fill")
                .font(.title)
                .foregroundStyle(color)
                .mask {
                    Image(systemName: "pencil.tip")
                        .font(.largeTitle)
                }
        }
    }
    
    @ViewBuilder
    func clearButton() -> some View {
        Button {
            lines.removeAll()
        } label: {
            Image(systemName: "pencil.tip.crop.circle.badge.minus")
                .font(.largeTitle)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    MainCanvas()
}
