//
//  MainCanvas.swift
//  iDibujo
//
//  Created by Israel Manzo on 6/15/24.
//  Copyright © 2024 Israel Manzo. All rights reserved.
//

import SwiftUI

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
            CanvasView(lines: $lines, selectedColor: $selectedColor)
        }
    }
    
    @ViewBuilder
    func colorButton(color: Color) -> some View {
        Button {
            selectedColor = color
        } label: {
            Image(systemName: "circle.fill")
                .font(.largeTitle)
                .foregroundStyle(color)
                .background(
                    Circle()
                        .stroke(.black, lineWidth: 4)
                )
//                .mask {
//                    Image(systemName: "pencil.tip")
//                        .font(.largeTitle)
//                }
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
