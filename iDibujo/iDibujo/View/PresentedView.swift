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
    @StateObject var vm: LineViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Line Width")
                .font(.headline)
            Slider(value: $vm.lineWithValue, in: 0...10, step: 0.1) 
            Text(String(format: "%.2f", vm.lineWithValue))
                .font(.headline)
        }
        .padding()
    }
}

#Preview {
    PresentedView(vm: .init())
}
