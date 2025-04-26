//
//  MainCanvas.swift
//  iDibujo
//
//  Created by Israel Manzo on 6/15/24.
//  Copyright © 2024 Israel Manzo. All rights reserved.
//
import SwiftUI

struct MainCanvas: View {
    @State private var showingAlert = false
    @State private var colorPicked: Color = .blue
    @State private var alert: AlertComponent? = nil
    @StateObject private var lineViewModel = LineViewModel()
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            CanvasView(
                lines: $lineViewModel.lines,
                selectedColor: $lineViewModel.selectedColor,
                deletedLines: $lineViewModel.deletedLines,
                vm: lineViewModel
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
            Menu {
                /// Clear `Canvas` button
                Button {
                    presentAlert()
                } label: {
                    HStack {
                        Image(systemName: CustomIcon.eraser)
                        Text(Labels.clearCanvas)
                    }
                }
                .disabled(lineViewModel.lines.isEmpty ? true : false)
                /// Back to `Canvas` button
                Button { } label: {
                    HStack {
                        Text(Labels.back)
                        Image(systemName: CustomIcon.backToCanvas)
                    }
                }
                /// Save to `Photo` Library  button
                Button {
                    savePhotoLibrary()
                } label: {
                    HStack {
                        Text(Labels.save)
                        Image(systemName: CustomIcon.saveCanvas)
                    }
                }
                .disabled(lineViewModel.lines.isEmpty ? true : false)
                
            } label: {
                Image(systemName: CustomIcon.pencil)
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
            }
            .presentAlert($alert, isPresented: $showingAlert)
            
            ColorPicker(Labels.colorPicker, selection: $lineViewModel.selectedColor)
                .labelsHidden()
        }
    }
    
    private func presentAlert() {
        showingAlert = true
        alert = .delete({
            lineViewModel.lines.removeAll()
        }, cancel: {
            self.showingAlert = false
        })
    }
    
    private func savePhotoLibrary() {
        lineViewModel.save(from: self)
    }
}

#Preview {
    MainCanvas()
}
