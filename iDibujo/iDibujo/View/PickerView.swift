//
//  PickerView.swift
//  iDibujo
//
//  Created by Israel Manzo on 2/20/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI

struct PickerView: View {
    @State var colorPicked: Color = .blue
    @State var mixer: Double = 0
    
    var body: some View {
        VStack {
            ColorPicker("PickColor", selection: $colorPicked)
                .labelsHidden()
            RoundedRectangle(cornerRadius: 5)
                .fill(colorPicked)
                .frame(width: 100, height: 100)
            
            Text("\((1 - mixer), format: .percent.precision(.fractionLength(0...2)))")
        }
    }
}

#Preview {
    PickerView()
}
