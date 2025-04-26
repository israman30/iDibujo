//
//  Extensions.swift
//  iDibujo
//
//  Created by Israel Manzo on 4/20/23.
//  Copyright © 2023 Israel Manzo. All rights reserved.
//

import UIKit
import SwiftUI

// MARK: - The extension provides a method to capture a snapshot of the displayed element or the view itself.
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

// MARK: - Custom button for each BUTTON color
class CustomButton: UIButton {
    
    convenience init(for title: String = "", titleColor: UIColor, background: UIColor, fontSize: CGFloat, imageString: String = "") {
        self.init()
        setTitle(title, for: .normal)
        tintColor = titleColor
        let fontLarge = UIFont.systemFont(ofSize: 30)
        let config = UIImage.SymbolConfiguration(font: fontLarge)
        let image = UIImage(systemName: imageString, withConfiguration: config)
        setImage(image, for: .normal)
        backgroundColor = background
        titleLabel?.font = .preferredFont(forTextStyle: .title3)
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.isAccessibilityElement = true
        layer.borderWidth = 3
        layer.borderColor = UIColor.black.cgColor
    }
}

// MARK: - Button extension with picker color background color + shadow for apply changes for settings controller
extension UIButton {
    
    func colorButton(color: UIColor, buttonTag: Int) {
        backgroundColor = color
        tag = buttonTag
    }
    
    func shadow() {
        layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        layer.shadowOpacity = 5
        layer.shadowRadius = 1.5
        clipsToBounds = false
        layer.cornerRadius = 5
    }
}

// MARK: - Color extension for each picker color on main controller
extension UIColor {
    // Method returns a custom color
    static var pink = UIColor(red: 255/255, green: 105/255, blue: 180, alpha: 1)
    static var resetColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    static var importColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
    static var eraseColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
    static var moreColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
}

// MARK: - Add a collection of subviews for a parent view
extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
