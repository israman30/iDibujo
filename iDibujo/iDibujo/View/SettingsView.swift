//
//  SettingsView.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/23/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension SettingsController {
    
    // MARK: - SETTING SLIDER FOR SETTINGS CONTROLLER
    func setSliders() {
        let redColor = UILabel()
        redColor.text = NSLocalizedString("Red", comment: "Red")
        let greenColor = UILabel()
        greenColor.text = NSLocalizedString("Green", comment: "Green")
        let blueColor = UILabel()
        blueColor.text = NSLocalizedString("Blue", comment: "Blue")
        
        let brushSizeStackView = UIStackView(arrangedSubviews: [brushLabel, UIView(), brushSizeLabel])
        brushSizeStackView.axis = .horizontal
        
        let redStackView = UIStackView(arrangedSubviews: [redColor, UIView(), redLabel])
        redStackView.axis = .horizontal
        
        let greenStackView = UIStackView(arrangedSubviews: [greenColor, UIView(), greenLabel])
        greenStackView.axis = .horizontal
        
        let blueStackView = UIStackView(arrangedSubviews: [blueColor, UIView(), blueLabel])
        blueStackView.axis = .horizontal
        
        let stackSliderView = UIStackView(arrangedSubviews: [
            brushSizeStackView,
            changeBrushSizeSlider,
            opacityLabel,
            opacitySlider,
            rgbLabel,
            redStackView,
            redSlider,
            greenStackView,
            greenSlider,
            blueStackView,
            blueSlider
            ])
        stackSliderView.distribution = .fillEqually
        stackSliderView.axis = .vertical
        
        changeBrushSizeSlider.accessibilityLabel = NSLocalizedString("Brush_Size", comment: "Brush Size")
        changeBrushSizeSlider.accessibilityHint = NSLocalizedString("Adjust_brush_size", comment: "Adjust brush size")
        opacitySlider.accessibilityLabel = NSLocalizedString("Opacity", comment: "Opacity")
        opacitySlider.accessibilityHint = NSLocalizedString("Adjust_opacity", comment: "Adjust opacity")
        redSlider.accessibilityLabel = NSLocalizedString("Red", comment: "Red")
        redSlider.accessibilityHint = NSLocalizedString("Adjust_red", comment: "Adjust red color")
        greenSlider.accessibilityLabel = NSLocalizedString("Green", comment: "Green")
        greenSlider.accessibilityHint = NSLocalizedString("Adjust_green", comment: "Adjust green color")
        blueSlider.accessibilityLabel = NSLocalizedString("Blue", comment: "Blue")
        blueSlider.accessibilityHint = NSLocalizedString("Adjust_blue", comment: "Adjust blue color")
        imageView.accessibilityLabel = NSLocalizedString("Brush_preview", comment: "Brush preview")
        imageView.isAccessibilityElement = true
        
        view.addSubview(stackSliderView)
        stackSliderView.anchor(
            top: imageView.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            padding: .init(top: 10, left: 30, bottom: 20, right: 30)
        )
    }
    
    // MARK: - SETTINGS VIEW FOR SETTING CONTROLLER
    func setSettingsView() {
        
        view.backgroundColor = .white
        
        view.addSubViews(dismissButton, closeButton, imageView)
        
        closeButton.accessibilityLabel = NSLocalizedString("Close", comment: "Close settings")
        closeButton.anchor(top: dismissButton.topAnchor, left: nil, bottom: nil, right: view.rightAnchor)
        
        dismissButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: nil,
            right: nil,
            padding: .init(top: 10, left: 5, bottom: 0, right: 0),
            size: .init(width: 180, height: 44)
        )
        dismissButton.backgroundColor = .yellow
        dismissButton.shadow()
        dismissButton.accessibilityLabel = NSLocalizedString("APPLY", comment: "Apply")
        dismissButton.accessibilityHint = NSLocalizedString("Apply_changes", comment: "Apply changes")
        
//        imageView.centerInSuperview(size: .init(width: 150, height: 150))
        imageView.layer.cornerRadius = 150 / 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
}

