//
//  SliderView.swift
//  iDibujo
//
//  Created by Israel Manzo on 4/26/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI

struct SliderView: View {
    @State var height: CGFloat = 150
    @State var dragOffset: CGFloat = 0
    @State var value: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .frame(width: 60, height: 150)
                .foregroundStyle(.gray)
            Rectangle()
                .frame(width: 60, height: min(150, max(height + dragOffset, dragOffset)))
        }
        .gesture(
            DragGesture()
                .onChanged({ value in
                    withAnimation {
                        dragOffset = -value.translation.height * 1.2
                        let newHeight = min(150, max(0, height + dragOffset))
                        self.value = newHeight / 150 * 100
                    }
                })
                .onEnded({ value in
                    height = min(150, max(0, height + dragOffset))
                    dragOffset = 0
                })
        )
        .clipShape(.rect(cornerRadius: 20))
        .frame(height: 150)
        .overlay {
            Text(String(format: "%.0f", value))
                .font(.title3)
                .foregroundStyle(.white)
                .contentTransition(.numericText())
        }
    }
}

#Preview {
    SliderView()
}
