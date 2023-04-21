//
//  SettingsController.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/23/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    var settingsViewModel = SettingsViewModel()
    
    var delegate: SettingsProtocol?
    
    let dismissButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(NSLocalizedString("APPLY", comment: "APPLY"), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return btn
    }()
    
    let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        let fontLarge = UIFont.systemFont(ofSize: 30)
        let config = UIImage.SymbolConfiguration(font: fontLarge)
        let image = UIImage(systemName: CustomIcon.xmark_square, withConfiguration: config)
        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    let imageView: UIImageView = {
        let brush = UIImageView()
        brush.isUserInteractionEnabled = true
        brush.autoresizesSubviews = true
        return brush
    }()
    
    let brushLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Brush_Size", comment: "Brush Size") 
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let brushSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let opacityLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Opacity", comment: "Opacity") 
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let rgbLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("RGB_Colors", comment: "RGB Colors") 
        label.textAlignment = .center
        label.textColor = .init(red: 141/255, green: 141/255, blue: 145/255, alpha: 1)
        label.font = .preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let redLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Red_Label", comment: "Red Label")
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let greenLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Green_Label", comment: "Green Label") 
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let blueLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Blue_Label", comment: "Blue Label")
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // MARK: - SLIDERS BLOCK
    let changeBrushSizeSlider: CustomSlider = {
        let slider = CustomSlider(firstColor: CustomColor.blackPrimary, secondColor: CustomColor.blackSecondary)
        slider.value = 10
        slider.minimumValue = 1
        slider.maximumValue = 90
        return slider
    }()
    
    let opacitySlider: CustomSlider = {
        let slider = CustomSlider(firstColor: CustomColor.blackPrimary, secondColor: CustomColor.blackSecondary)
        slider.setValue(1, animated: true)
        return slider
    }()
    
    let redSlider: CustomSlider = {
        let slider = CustomSlider(firstColor: CustomColor.redPrimary, secondColor: CustomColor.redSecondary)
        slider.minimumTrackTintColor = .red
        slider.thumbTintColor = .red
        return slider
    }()
    
    let greenSlider: CustomSlider = {
        let slider = CustomSlider(firstColor: CustomColor.greenPrimary, secondColor: CustomColor.greenSecondary)
        slider.minimumTrackTintColor = .green
        slider.thumbTintColor = .green
        return slider
    }()
    
    let blueSlider: CustomSlider = {
        let slider = CustomSlider(firstColor: CustomColor.bluePrimary, secondColor: CustomColor.blueSecondary)
        slider.minimumTrackTintColor = .blue
        slider.thumbTintColor = .blue
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blueSlider.addTarget(self, action: #selector(handleBlueColor), for: .valueChanged)
        greenSlider.addTarget(self, action: #selector(handleGreenColor), for: .valueChanged)
        redSlider.addTarget(self, action: #selector(handleRedColor), for: .valueChanged)
        opacitySlider.addTarget(self, action: #selector(handleChangeOpacitySize), for: .valueChanged)
        changeBrushSizeSlider.addTarget(self, action: #selector(handleChangeBrushSize), for: .valueChanged)
        dismissButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        
        previewDraw(red: settingsViewModel.draw.red, green: settingsViewModel.draw.green, blue: settingsViewModel.draw.blue)
        
        redSlider.value = Float(settingsViewModel.draw.red)
        redLabel.text = String(Int(redSlider.value * 255))
        
        greenSlider.value = Float(settingsViewModel.draw.green)
        greenLabel.text = String(Int(greenSlider.value * 255))
        
        blueSlider.value = Float(settingsViewModel.draw.blue)
        blueLabel.text = String(Int(blueSlider.value * 255))
        
        setSettingsView()
        setSliders()
    }
    
    
}

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
    
    // Step 3
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
        let thumbRectA = thumbRect(forBounds: bounds,
                                   trackRect: trackRect(forBounds: bounds),
                                   value: value)
        trackLayer.frame = .init(x: 0,
                                 y: frame.height / 4,
                                 width: thumbRectA.midX,
                                 height: frame.height / 2)
        // Step 9
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
        let middleView = UIView(frame: .init(x: frame.midX - 6,
                                             y: frame.midY - 6,
                                             width: 12,
                                             height: 12))
        middleView.backgroundColor = .white
        middleView.layer.cornerRadius = 6
        addSubview(middleView)
    }
}

extension UIView {
 
    var snapshot: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let capturedImage = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return capturedImage
    }
}
