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
    @State private var presentSheet = false
    @State private var settingsDetent = PresentationDetent.medium
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                menuList()
            }
            .padding(.horizontal)
            
            CanvasView(lines: $lines, selectedColor: $selectedColor)
            
            HStack {
                ForEach(colors, id: \.self) { color in
                    colorButton(color: color)
                }
            }
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
        }
    }
    
    @ViewBuilder
    func menuList() -> some View {
        Menu {
            Button {
                self.showingAlert = true
            } label: {
                HStack {
                    Image(systemName: "eraser")
                    Text("Clear")
                }
            }
            .disabled(lines.isEmpty ? true : false)
            
            Button {
                self.presentSheet = true
            } label: {
                Image(systemName: "scribble.variable")
                Text("Adjust")
            }
        } label: {
            Image(systemName: "pencil.tip.crop.circle.badge.arrow.forward")
                .font(.largeTitle)
                .foregroundStyle(.gray)
        }
        .sheet(isPresented: $presentSheet, content: {
            EmptyView()
                .presentationDetents([.medium, .large], selection: $settingsDetent)
        })
        .alert("Are you deleting your art?", isPresented: $showingAlert) {
            Button("Yes", role: .destructive) {
                lines.removeAll()
            }
            Button("No", role: .cancel) { }
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
