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
            
            CanvasView(
                lines: $lineViewModel.lines,
                selectedColor: $lineViewModel.selectedColor,
                deletedLines: $lineViewModel.deletedLines,
                vm: lineViewModel
            )
            .ignoresSafeArea(edges: .all)
            
            VStack {
                HStack {
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
            .padding(.vertical, 5)
        }
    }
    
    @ViewBuilder
    func colorButton(color: Color) -> some View {
        Button {
            lineViewModel.selectedColor = color
        } label: {
            Image(systemName: CustomIcon.circleFill)
                .font(.largeTitle)
                .foregroundStyle(color)
                .background(
                    Circle()
                        .stroke(.black, lineWidth: 4)
                )
        }
        .buttonStyle(.borderless)
    }
    
    @ViewBuilder
    func menuList() -> some View {
        HStack {
            MenuButtonView(lineViewModel: lineViewModel) {
                saveToPhotoLibrary()
            } presentAlertAction: {
                presentAlert()
            }

            ColorPicker("Color Picker", selection: $lineViewModel.selectedColor)
                .foregroundStyle(.black)
                .labelsHidden()
        }
    }
    
    private func presentAlert() {
        
    }
    
    private func saveToPhotoLibrary() {
        lineViewModel.saveCanvas(from: self)
    }
}

#Preview {
    ContentView()
}


struct MenuButtonView: View {
    var lineViewModel: LineViewModel
    var savePhotoLibraryAction: () -> Void
    var presentAlertAction: () -> Void
    
    var body: some View {
        HStack {
            Button {
                presentAlertAction()
            } label: {
                HStack {
                    Image(systemName: CustomIcon.eraser)
                }
                .foregroundStyle(.black)
            }
            
            
            Button {
                savePhotoLibraryAction()
            } label: {
                HStack {
                    Image(systemName: CustomIcon.saveCanvas)
                }
                .foregroundStyle(.black)
            }
        }
    }
}
