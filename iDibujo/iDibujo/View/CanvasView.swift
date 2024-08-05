//
//  CanvasView.swift
//  iDibujo
//
//  Created by Israel Manzo on 6/16/24.
//  Copyright © 2024 Israel Manzo. All rights reserved.
//

import SwiftUI

struct CanvasView: View {
    
    @Binding var lines: [Line]
    @Binding var selectedColor: Color
    @State var vm: LineViewModel
    @State var newValue: [CGFloat] = []
    
    var body: some View {
        Canvas { context, size in
            lines.forEach {
                var path = Path()
                self.newValue.append(vm.lineWithValue)
                path.addLines($0.points)
                path.addLines(newValue)
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

