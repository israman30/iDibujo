//
//  Anchors+Ext.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/23/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

// MARK: - Custom button for each BUTTON color
class CustomButton: UIButton {
    
    convenience init(for title: String = "", titleColor: UIColor, background: UIColor, fontSize: CGFloat, imageString: String = "") {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        tintColor = .white
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

// MARK: -  ANCHOR CONSTRAINT EXTENSION VIEW FOR AUTOLAYOUT
struct AnchoredConstraints {
    var top, left, bottom, right, width, height: NSLayoutConstraint?
}

extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(
                equalTo: top,
                constant: padding.top
            )
        }
        
        if let left = left {
            anchoredConstraints.left = leftAnchor.constraint(
                equalTo: left,
                constant: padding.left
            )
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(
                equalTo: bottom,
                constant: -padding.bottom
            )
        }
        
        if let right = right {
            anchoredConstraints.right = rightAnchor.constraint(
                equalTo: right,
                constant: -padding.right
            )
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(
                equalToConstant: size.width
            )
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(
                equalToConstant: size.height
            )
        }
        
        [anchoredConstraints.top,
         anchoredConstraints.left,
         anchoredConstraints.bottom,
         anchoredConstraints.right,
         anchoredConstraints.width,
         anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(
                equalTo: superviewTopAnchor,
                constant: padding.top
                ).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(
                equalTo: superviewBottomAnchor,
                constant: -padding.bottom
                ).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(
                equalTo: superviewLeadingAnchor,
                constant: padding.left
                ).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(
                equalTo: superviewTrailingAnchor,
                constant: -padding.right
                ).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
}
