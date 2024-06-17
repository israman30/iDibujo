//
//  PresentedView.swift
//  iDibujo
//
//  Created by Israel Manzo on 6/16/24.
//  Copyright © 2024 Israel Manzo. All rights reserved.
//

import SwiftUI

struct PresentedView: View {
    
    @State var value = 5.0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Line Width")
                .font(.headline)
            Slider(value: $value, in: 0...10, step: 0.1)
            Text(String(format: "%.2f", value))
                .font(.headline)
        }
        .padding()
    }
}

#Preview {
    PresentedView()
}
