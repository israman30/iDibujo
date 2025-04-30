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
            Image(systemName: CustomIcon.circleFill)
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
            MenuButtonView(lineViewModel: lineViewModel) {
                saveToPhotoLibrary()
            } presentAlertAction: {
                presentAlert()
            }

            ColorPicker("", selection: $lineViewModel.selectedColor)
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
        VStack {
            Button {
                presentAlertAction()
            } label: {
                HStack {
                    Image(systemName: CustomIcon.eraser)
                    Text(Labels.clearCanvas)
                }
                .foregroundStyle(.black)
            }
            
            Button {
                savePhotoLibraryAction()
            } label: {
                HStack {
                    Image(systemName: CustomIcon.saveCanvas)
                    Text(Labels.save)
                }
                .foregroundStyle(.black)
            }
        }
    }
}
