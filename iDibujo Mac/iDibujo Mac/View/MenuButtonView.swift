//
//  MenuButtonView.swift
//  iDibujo Mac
//
//  Created by Israel Manzo on 4/30/25.
//

import SwiftUI

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
