//
//  CustomSlider.swift
//  iDibujo
//
//  Created by Israel Manzo on 4/20/23.
//  Copyright © 2023 Israel Manzo. All rights reserved.
//

import UIKit

final class CustomSlider: UISlider {
    
    private let baseLayer = CALayer()
    private let trackLayer = CAGradientLayer()
    var firstColor: UIColor? = nil
    var secondColor: UIColor? = nil
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }
    
    init(firstColor: UIColor? = nil, secondColor: UIColor? = nil) {
        super.init(frame: .zero)
        self.firstColor = firstColor
        self.secondColor = secondColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        clear()
        createBaseLayer()
        createThumbImageView()
        configureTrackLayer()
        addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    private func clear() {
        tintColor = .clear
        maximumTrackTintColor = .clear
        backgroundColor = .clear
        thumbTintColor = .clear
    }
    
    private func createBaseLayer() {
        baseLayer.borderWidth = 1
        baseLayer.borderColor = UIColor.lightGray.cgColor
        baseLayer.masksToBounds = true
        baseLayer.backgroundColor = UIColor.white.cgColor
        baseLayer.frame = .init(x: 0, y: frame.height / 4, width: frame.width, height: frame.height / 2)
        baseLayer.cornerRadius = baseLayer.frame.height / 2
        layer.insertSublayer(baseLayer, at: 0)
    }
    
    private func createThumbImageView() {
        let thumbSize = (3 * frame.height) / 4
        let thumbView = ThumbView(frame: .init(x: 0, y: 0, width: thumbSize, height: thumbSize))
        thumbView.layer.cornerRadius = thumbSize / 2
        let thumbSnapshot = thumbView.snapshot
        setThumbImage(thumbSnapshot, for: .normal)
        setThumbImage(thumbSnapshot, for: .highlighted)
        setThumbImage(thumbSnapshot, for: .application)
        setThumbImage(thumbSnapshot, for: .disabled)
        setThumbImage(thumbSnapshot, for: .focused)
        setThumbImage(thumbSnapshot, for: .reserved)
        setThumbImage(thumbSnapshot, for: .selected)
    }
    
    private func configureTrackLayer() {
        trackLayer.colors = [firstColor?.cgColor ?? UIColor(), secondColor?.cgColor ?? UIColor()]
        trackLayer.startPoint = .init(x: 0, y: 0.5)
        trackLayer.endPoint = .init(x: 1, y: 0.5)
        trackLayer.frame = .init(x: 0, y: frame.height / 4, width: 0, height: frame.height / 2)
        trackLayer.cornerRadius = trackLayer.frame.height / 2
        layer.insertSublayer(trackLayer, at: 1)
    }
    
    @objc private func valueChanged(_ sender: UISlider) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let thumbRectA = thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
        trackLayer.frame = .init(x: 0, y: frame.height / 4, width: thumbRectA.midX, height: frame.height / 2)
        
        CATransaction.commit()
    }
}

final class ThumbView: UIView {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
 
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
 
    private func setup() {
        backgroundColor = CustomColor.blackSecondary
        let middleView = UIView(frame: .init(x: frame.midX - 6, y: frame.midY - 6, width: 12, height: 12))
        middleView.backgroundColor = .white
        middleView.layer.cornerRadius = 6
        addSubview(middleView)
    }
}

extension UIView {
    var snapshot: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let capturedImage = renderer.image {
            layer.render(in: $0.cgContext)
        }
        return capturedImage
    }
}
