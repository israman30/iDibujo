//
//  MainCanvas.swift
//  iDibujo
//
//  Created by Israel Manzo on 6/15/24.
//  Copyright © 2024 Israel Manzo. All rights reserved.
//

import SwiftUI

final class LineViewModel: ObservableObject {
    @Published var lineWithValue: CGFloat = 5.0
    @Published var lines = [Line]()
    @Published var colors: [Color] = [.green, .orange, .blue, .red, .pink, .black, .purple]
    @Published var selectedColor = Color.black
}

struct MainCanvas: View {
    
    @State private var presentSheet = false
    @State private var settingsDetent = PresentationDetent.medium
    @State private var showingAlert = false
    @StateObject private var lineViewModel = LineViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                menuList()
            }
            .padding(.horizontal)
            
            CanvasView(
                lines: $lineViewModel.lines,
                selectedColor: $lineViewModel.selectedColor, vm: lineViewModel
            )
            
            HStack {
                ForEach(lineViewModel.colors, id: \.self) { color in
                    colorButton(color: color)
                }
            }
        }
    }
    
    @ViewBuilder
    func colorButton(color: Color) -> some View {
        Button {
            lineViewModel.selectedColor = color
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
            .disabled(lineViewModel.lines.isEmpty ? true : false)
            
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
            PresentedView(vm: lineViewModel)
                .presentationDetents([.medium, .large], selection: $settingsDetent)
        })
        .alert("Are you deleting your art?", isPresented: $showingAlert) {
            Button("Yes", role: .destructive) {
                lineViewModel.lines.removeAll()
            }
            Button("No", role: .cancel) { }
        }
    }
    
    @ViewBuilder
    func clearButton() -> some View {
        Button {
            lineViewModel.lines.removeAll()
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
