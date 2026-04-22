//
//  TutorialPopupView.swift
//  iDibujo
//
//  Created by Cursor on 4/21/26.
//

import SwiftUI
import UIKit

struct TutorialPopupView: View {
    private enum FocusTarget: Hashable {
        case closeButton
        case primaryAction
    }
    
    struct Page: Identifiable {
        let id: Int
        let title: String
        let message: String
        let assetName: String?
        let systemImage: String
        let tint: Color
    }
    
    let onDismiss: () -> Void
    
    @State private var selection: Int = 0
    @AccessibilityFocusState private var focusedTarget: FocusTarget?
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    private let pages: [Page] = [
        .init(
            id: 0,
            title: NSLocalizedString("Draw with brushes", comment: "Tutorial page title"),
            message: NSLocalizedString("Pick a brush, adjust the stroke size, and start drawing on the canvas.", comment: "Tutorial page message"),
            assetName: "tutorial_brushes",
            systemImage: "paintbrush.pointed",
            tint: .blue
        ),
        .init(
            id: 1,
            title: NSLocalizedString("Change colors & backgrounds", comment: "Tutorial page title"),
            message: NSLocalizedString("Use the color palette or color picker, and switch backgrounds (white, grid, lined paper, or an image).", comment: "Tutorial page message"),
            assetName: "tutorial_colors",
            systemImage: "paintpalette",
            tint: .pink
        ),
        .init(
            id: 2,
            title: NSLocalizedString("Undo, redo & save", comment: "Tutorial page title"),
            message: NSLocalizedString("Undo/redo strokes anytime. When you're done, save your drawing to Photos.", comment: "Tutorial page message"),
            assetName: "tutorial_save",
            systemImage: "arrow.uturn.left.circle",
            tint: .green
        )
    ]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.45)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }
                .accessibilityHidden(true)
            
            VStack(spacing: 14) {
                HStack {
                    Spacer()
                    Button(action: dismiss) {
                        Image(systemName: CustomIcon.xmark_circle_fill)
                            .font(.title2)
                            .foregroundStyle(.secondary)
                            .accessibilityLabel(NSLocalizedString("Close tutorial", comment: "Close tutorial accessibility label"))
                            .accessibilityHint(NSLocalizedString("Dismisses the tutorial and returns to the canvas.", comment: "Close tutorial accessibility hint"))
                    }
                    .buttonStyle(.plain)
                    .accessibilityFocused($focusedTarget, equals: .closeButton)
                }
                
                TabView(selection: $selection) {
                    ForEach(pages) { page in
                        tutorialPage(page)
                            .tag(page.id)
                            .padding(.horizontal, 8)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height: 360)
                
                HStack(spacing: 12) {
                    Button(NSLocalizedString("Skip", comment: "Skip tutorial button")) {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    if selection < (pages.count - 1) {
                        Button(NSLocalizedString("Next", comment: "Next tutorial page button")) {
                            if reduceMotion {
                                selection = min(selection + 1, pages.count - 1)
                            } else {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    selection = min(selection + 1, pages.count - 1)
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .accessibilityFocused($focusedTarget, equals: .primaryAction)
                    } else {
                        Button(NSLocalizedString("Done", comment: "Finish tutorial button")) {
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .accessibilityFocused($focusedTarget, equals: .primaryAction)
                    }
                }
            }
            .padding(18)
            .frame(maxWidth: 440)
            .background(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(Color(uiColor: .systemBackground))
                    .shadow(color: .black.opacity(0.18), radius: 18, y: 8)
            )
            .padding(18)
            .accessibilityElement(children: .contain)
            .accessibilityAddTraits(.isModal)
            .accessibilityAction(.escape) { dismiss() }
            .onAppear {
                focusedTarget = .closeButton
            }
        }
    }
    
    private func tutorialPage(_ page: Page) -> some View {
        ScrollView {
            VStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(page.tint.opacity(0.14))
                    
                    if let assetName = page.assetName,
                       let uiImage = UIImage(named: assetName) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .padding(18)
                    } else {
                        Image(systemName: page.systemImage)
                            .font(.system(size: 54, weight: .semibold))
                            .foregroundStyle(page.tint)
                    }
                }
                .frame(height: 180)
                .accessibilityHidden(true)
                
                VStack(spacing: 8) {
                    Text(page.title)
                        .font(.title2.weight(.semibold))
                        .multilineTextAlignment(.center)
                        .accessibilityAddTraits(.isHeader)
                    
                    Text(page.message)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 12)
            }
            .padding(.top, 6)
            .frame(maxWidth: .infinity)
        }
        .scrollIndicators(.hidden)
    }
    
    private func dismiss() {
        onDismiss()
    }
}

#Preview {
    TutorialPopupView(onDismiss: {})
}

