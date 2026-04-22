//
//  MainCanvas.swift
//  iDibujo
//
//  Created by Israel Manzo on 6/15/24.
//  Copyright © 2024 Israel Manzo. All rights reserved.
//
import SwiftUI

struct MainCanvas: View {
    @AppStorage("hasShownTutorial") private var hasShownTutorial: Bool = false
    @Environment(\.verticalSizeClass) private var orientation
    @Environment(\.colorScheme) private var colorScheme
    @State private var showingAlert = false
    @State private var alert: AlertComponent? = nil
    @State private var isTutorialPresented: Bool = false
    private let colorPaletteNames = ["Red", "Yellow", "Blue", "Green", "Orange", "Pink", "Black"]
    
    @StateObject private var lineViewModel = LineViewModel()
    
    var body: some View {
        ZStack {
            // Adaptive background for light/dark mode
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            CanvasView(
                lines: $lineViewModel.lines,
                selectedColor: $lineViewModel.selectedColor,
                deletedLines: $lineViewModel.deletedLines,
                vm: lineViewModel
            )
            .ignoresSafeArea()
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(Labels.a11yDrawingCanvas)
            .accessibilityHint(Labels.a11yDrawingCanvasHint)
            
            VStack {
                HStack {
                    Spacer()
                    menuList()
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                Spacer()
                colorPaletteView
            }
            ToastView(
                text: Labels.canvasSaved,
                isVisible: $lineViewModel.isSaved
            )
            .accessibilityLabel(Labels.canvasSaved)
            
            if isTutorialPresented {
                TutorialPopupView(onDismiss: {
                    isTutorialPresented = false
                })
                .transition(.opacity)
                .zIndex(10)
            }
        }
        .onAppear {
            if !hasShownTutorial {
                hasShownTutorial = true
                isTutorialPresented = true
            }
        }
    }
    
    private var colorPaletteView: some View {
        HStack(spacing: 12) {
            ForEach(Array(lineViewModel.colors.enumerated()), id: \.offset) { index, color in
                colorButton(color: color, name: colorPaletteNames.indices.contains(index) ? colorPaletteNames[index] : "Color")
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color(red: 0.92, green: 0.92, blue: 0.94))
                .shadow(color: colorScheme == .dark ? .black.opacity(0.2) : .black.opacity(0.08), radius: 12, y: 4)
        )
        .padding(.bottom, 10)
    }
    
    @ViewBuilder
    func colorButton(color: Color, name: String) -> some View {
        let isSelected = lineViewModel.selectedColor == color
        Button {
            lineViewModel.selectedColor = color
        } label: {
            Circle()
                .fill(color)
                .frame(width: 36, height: 36)
                .overlay(
                    Circle()
                        .stroke(isSelected ? Color.primary : Color.clear, lineWidth: 3)
                )
                .overlay(
                    Circle()
                        .stroke(.white.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: color.opacity(0.4), radius: isSelected ? 6 : 2)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(name) \(Labels.a11ySelectColor)")
        .accessibilityHint(isSelected ? "\(Labels.a11yColorSelected)" : Labels.a11ySelectColor)
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
    }
    
    @ViewBuilder
    func menuList() -> some View {
        if orientation == .regular {
            VStack(spacing: 16) {
                // Toolbar container with material background
                VStack(spacing: 20) {
                    MenuButtonView(lineViewModel: lineViewModel, savePhotoLibrary: {
                        savePhotoLibrary()
                    }, presentAlert: {
                        presentAlert()
                    }, showTutorial: {
                        isTutorialPresented = true
                    })
                    .presentAlert($alert, isPresented: $showingAlert)
                    
                    BackgroundPickerView(
                        selectedBackground: $lineViewModel.selectedBackground,
                        customBackgroundImage: $lineViewModel.customBackgroundImage
                    )
                    
                    BrushPickerView(selectedBrush: $lineViewModel.selectedBrushType)
                    
                    ColorPicker(Labels.colorPicker, selection: $lineViewModel.selectedColor)
                        .labelsHidden()
                        .accessibilityLabel(Labels.colorPicker)
                    
                    SliderView(value: $lineViewModel.lineWithValue)
                    
                    UndoRedoButtonView(lineViewModel: lineViewModel)
                }
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(red: 0.92, green: 0.92, blue: 0.94))
                        .shadow(color: colorScheme == .dark ? .black.opacity(0.2) : .black.opacity(0.08), radius: 12, y: 4)
                )
            }
        } else {
            VStack(spacing: 12) {
                HStack(spacing: 16) {
                    BrushPickerView(selectedBrush: $lineViewModel.selectedBrushType)
                    
                    BackgroundPickerView(
                        selectedBackground: $lineViewModel.selectedBackground,
                        customBackgroundImage: $lineViewModel.customBackgroundImage
                    )
                    
                    ColorPicker(Labels.colorPicker, selection: $lineViewModel.selectedColor)
                        .labelsHidden()
                        .accessibilityLabel(Labels.colorPicker)
                    
                    UndoRedoButtonView(lineViewModel: lineViewModel)
                    
                    MenuButtonView(lineViewModel: lineViewModel, savePhotoLibrary: {
                        savePhotoLibrary()
                    }, presentAlert: {
                        presentAlert()
                    }, showTutorial: {
                        isTutorialPresented = true
                    })
                    .presentAlert($alert, isPresented: $showingAlert)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(red: 0.92, green: 0.92, blue: 0.94))
                        .shadow(color: colorScheme == .dark ? .black.opacity(0.2) : .black.opacity(0.08), radius: 12, y: 4)
                )
                   
                HStack {
                    Spacer()
                    SliderView(value: $lineViewModel.lineWithValue)
                }
            }
        }
    }
    
    private func presentAlert() {
        showingAlert = true
        alert = .delete({
            lineViewModel.clearCanvas()
        }, cancel: {
            self.showingAlert = false
        })
    }
    
    private func savePhotoLibrary() {
        lineViewModel.save(from: self)
    }
}

#Preview("Light") {
    MainCanvas()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    MainCanvas()
        .preferredColorScheme(.dark)
}

struct MenuButtonView: View {
    var lineViewModel: LineViewModel
    var savePhotoLibrary: () -> Void
    var presentAlert: () -> Void
    var showTutorial: () -> Void
    
    var body: some View {
        Menu {
            Button {
                showTutorial()
            } label: {
                Label(Labels.tutorial, systemImage: CustomIcon.tutorial)
            }
            .accessibilityHint(NSLocalizedString("Shows a quick tutorial on how to use the app.", comment: "Tutorial menu item accessibility hint"))
            
            Button {
                presentAlert()
            } label: {
                Label(Labels.clearCanvas, systemImage: CustomIcon.eraser)
            }
            .disabled(lineViewModel.lines.isEmpty)
            
            Button { } label: {
                Label(Labels.back, systemImage: CustomIcon.backToCanvas)
            }
            
            Button {
                savePhotoLibrary()
            } label: {
                Label(Labels.save, systemImage: CustomIcon.saveCanvas)
            }
            .disabled(lineViewModel.lines.isEmpty)
        } label: {
            Image(systemName: CustomIcon.pencil)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.primary)
                .frame(width: 44, height: 44)
                .background(Color(uiColor: .secondarySystemFill))
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(NSLocalizedString("Drawing menu", comment: "Drawing menu accessibility"))
        .accessibilityHint(Labels.a11yMenuHint)
    }
}

struct UndoRedoButtonView: View {
    @ObservedObject var lineViewModel: LineViewModel
    @Environment(\.verticalSizeClass) private var orientation
    
    private var canUndo: Bool { !lineViewModel.lines.isEmpty }
    private var canRedo: Bool { !lineViewModel.deletedLines.isEmpty }
    
    var body: some View {
        if orientation == .regular {
            redoButtonPortraitOrientation
        } else {
            redoButtonLandscapeOrientation
        }
    }
    
    private func undoRedoButton(
        icon: String,
        label: String,
        hint: String,
        action: @escaping () -> Void,
        isDisabled: Bool
    ) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(isDisabled ? AnyShapeStyle(.secondary.opacity(0.5)) : AnyShapeStyle(.primary))
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(isDisabled ? Color.clear : Color(uiColor: .secondarySystemFill))
                )
        }
        .disabled(isDisabled)
        .buttonStyle(.plain)
        .accessibilityLabel(label)
        .accessibilityHint(hint)
    }
    
    @ViewBuilder
    private var redoButtonPortraitOrientation: some View {
        VStack(spacing: 12) {
            undoRedoButton(
                icon: CustomIcon.undo,
                label: Labels.a11yUndo,
                hint: Labels.a11yUndoHint,
                action: { lineViewModel.undo() },
                isDisabled: !canUndo
            )
            undoRedoButton(
                icon: CustomIcon.redo,
                label: Labels.a11yRedo,
                hint: Labels.a11yRedoHint,
                action: { lineViewModel.redo() },
                isDisabled: !canRedo
            )
        }
    }
    
    @ViewBuilder
    private var redoButtonLandscapeOrientation: some View {
        HStack(spacing: 12) {
            undoRedoButton(
                icon: CustomIcon.undo,
                label: Labels.a11yUndo,
                hint: Labels.a11yUndoHint,
                action: { lineViewModel.undo() },
                isDisabled: !canUndo
            )
            undoRedoButton(
                icon: CustomIcon.redo,
                label: Labels.a11yRedo,
                hint: Labels.a11yRedoHint,
                action: { lineViewModel.redo() },
                isDisabled: !canRedo
            )
        }
    }
}

