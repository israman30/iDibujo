//
//  ContentView.swift
//  iDibujo Mac
//
//  Created by Israel Manzo on 4/29/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert: Bool = false
    @State private var colorPicked: Color = .blue
    @State private var alertTitle: String = ""
    @StateObject private var lineViewModel = LineViewModel()
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(edges: .all)
        }
    }
}

#Preview {
    ContentView()
}
