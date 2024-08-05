//
//  PresentedView.swift
//  iDibujo
//
//  Created by Israel Manzo on 6/16/24.
//  Copyright © 2024 Israel Manzo. All rights reserved.
//

import SwiftUI

struct PresentedView: View {
    
    @State var value: CGFloat = 5.0
    @StateObject var vm: LineViewModel
    var closure: ((CGFloat) -> ())? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Line Width")
                .font(.headline)
            Slider(value: $value, in: 0...10, step: 0.1)
            Text(String(format: "%.2f", value))
                .font(.headline)
        }
        .onChange(of: value, perform: { value in
            self.value = value
            closure!(value)
        })
        
        .padding()
    }
}

#Preview {
    PresentedView(vm: .init())
}
