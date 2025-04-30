//
//  UndoRedoButton.swift
//  iDibujo Mac
//
//  Created by Israel Manzo on 4/30/25.
//

import SwiftUI

struct UndoRedoButtonView: View {
    @ObservedObject var lineViewModel: LineViewModel
    
    var body: some View {
        HStack {
            /// `undo` Button
            Button {
                let lastLine = lineViewModel.lines.removeLast()
                lineViewModel.deletedLines.append(lastLine)
            } label: {
                Image(systemName: CustomIcon.undo)
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundStyle(.black)
            }
            .disabled(lineViewModel.lines.count == 0)
            .if(lineViewModel.lines.count == 0)
            /// `redo` Buton
            Button {
                let lastLine = lineViewModel.deletedLines.removeLast()
                lineViewModel.lines.append(lastLine)
            } label: {
                Image(systemName: CustomIcon.redo)
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundStyle(.black)
            }
            .disabled(lineViewModel.deletedLines.count == 0)
            .if(lineViewModel.deletedLines.count == 0)
        }
    }
}
