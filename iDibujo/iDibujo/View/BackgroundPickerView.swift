//
//  BackgroundPickerView.swift
//  iDibujo
//
//  Created by Israel Manzo on 3/2/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI
import PhotosUI

struct BackgroundPickerView: View {
    @Binding var selectedBackground: CanvasBackgroundType
    @Binding var customBackgroundImage: UIImage?
    @State private var selectedPhotoItem: PhotosPickerItem?
    
    var body: some View {
        Menu {
            ForEach(CanvasBackgroundType.allCases) { type in
                Button {
                    selectedBackground = type
                } label: {
                    Label(type.label, systemImage: type.icon)
                }
            }
            
            Divider()
            
            PhotosPicker(
                selection: $selectedPhotoItem,
                matching: .images
            ) {
                Label(Labels.backgroundCustom, systemImage: CanvasBackgroundType.customImage.icon)
            }
            .onChange(of: selectedPhotoItem) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        await MainActor.run {
                            customBackgroundImage = image
                            selectedBackground = .customImage
                        }
                    }
                }
            }
        } label: {
            Image(systemName: "square.3.layers.3d.down.right")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.primary)
                .frame(width: 44, height: 44)
                .background(Color(uiColor: .secondarySystemFill))
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Background: \(selectedBackground.label)")
        .accessibilityHint(Labels.a11yBackgroundPickerHint)
    }
}
