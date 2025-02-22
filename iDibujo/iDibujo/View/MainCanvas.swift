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
    @State var colorPicked: Color = .blue
    @StateObject private var lineViewModel = LineViewModel()
    
    var body: some View {
        ZStack {
            CanvasView(
                lines: $lineViewModel.lines,
                selectedColor: $lineViewModel.selectedColor, vm: lineViewModel
            )
            .ignoresSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    menuList()
                }
                .padding(.horizontal)
                Spacer()
                HStack {
                    ForEach(lineViewModel.colors, id: \.self) { color in
                        colorButton(color: color)
                    }
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
        VStack {
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
                
                Button { } label: {
                    Text("Back")
                }
            } label: {
                Image(systemName: "pencil.tip.crop.circle.badge.arrow.forward")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
            }
            .alert("Are you deleting your art?", isPresented: $showingAlert) {
                Button("Yes", role: .destructive) {
                    lineViewModel.lines.removeAll()
                }
                Button("No", role: .cancel) { }
            }
            ColorPicker("PickColor", selection: $lineViewModel.selectedColor)
                .labelsHidden()
                .onChange(of: lineViewModel.selectedColor) { oldValue, newValue in
                    self.colorPicked = newValue
                }
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
