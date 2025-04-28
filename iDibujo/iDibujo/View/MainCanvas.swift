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
            MenuButtonView(lineViewModel: lineViewModel, savePhotoLibrary: {
                savePhotoLibrary()
            }, presentAlert: {
                presentAlert()
            })
            .presentAlert($alert, isPresented: $showingAlert)
            
            ColorPicker(Labels.colorPicker, selection: $lineViewModel.selectedColor)
                .labelsHidden()
            
            SliderView(value: $lineViewModel.lineWithValue)
            
            UndoRedoButtonView(lineViewModel: lineViewModel)
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

struct MenuButtonView: View {
    var lineViewModel: LineViewModel
    var savePhotoLibrary: () -> Void
    var presentAlert: () -> Void
    
    var body: some View {
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
    }
}

struct UndoRedoButtonView: View {
    @ObservedObject var lineViewModel: LineViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            /// `undo` Button
            Button {
                let lastLine = lineViewModel.lines.removeLast()
                lineViewModel.deletedLines.append(lastLine)
            } label: {
                Image(systemName: "arrow.clockwise")
                    .font(.title3)
                    .fontWeight(.heavy)
            }
            .disabled(lineViewModel.lines.count == 0)
            .if(lineViewModel.lines.count == 0)
            /// `redo` Buton
            Button {
                let lastLine = lineViewModel.deletedLines.removeLast()
                lineViewModel.lines.append(lastLine)
            } label: {
                Image(systemName: "arrow.counterclockwise")
                    .font(.title3)
                    .fontWeight(.heavy)
            }
            .disabled(lineViewModel.deletedLines.count == 0)
            .if(lineViewModel.deletedLines.count == 0)
        }
    }
}
