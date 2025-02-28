//
//  MainCanvas.swift
//  iDibujo
//
//  Created by Israel Manzo on 6/15/24.
//  Copyright © 2024 Israel Manzo. All rights reserved.
//
import SwiftUI
import PhotosUI

struct MainCanvas: View {
    @State private var showingAlert = false
    @State private var colorPicked: Color = .blue
    @State private var alert: AlertComponent? = nil
    @StateObject private var lineViewModel = LineViewModel()
    
    @State var photosPickerItem: PhotosPickerItem?
    @State var coverImage: UIImage? = nil
    
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
        .onChange(of: photosPickerItem) { oldValue, newValue in
            Task {
                if let photosPickerItem, let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
//                        coverImage = image
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
            
            PhotosPicker(selection: $photosPickerItem, matching: .images) {
                Image(systemName: "photo.circle")
                    .font(.largeTitle)
                    .foregroundStyle(Color(.systemGray))
            }
            ColorPicker(Labels.colorPicker, selection: $lineViewModel.selectedColor)
                .labelsHidden()
                .onChange(of: lineViewModel.selectedColor) { oldValue, newValue in
                    self.colorPicked = newValue
                }
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
