//
//  StatButton.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 04..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class StatButton: UIButton {
    
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if isSelected == false {
            if self.traitCollection.userInterfaceStyle == .light {
                backgroundColor = .systemBackground
                layer.borderColor = Colors.statButtonBorderLightMode.color.cgColor
                label.textColor = Colors.statButtonLabelLightMode.color
            } else {
                backgroundColor = .systemBackground
                layer.borderColor = Colors.orange.color.cgColor
                label.textColor = Colors.orange.color
            }
        }
    }
    
    private func setup() {
        configureButton()
        configureLabel()
    }
    
    private func configureButton() {
        layer.cornerRadius = 13.5
        layer.borderColor = Colors.orange.color.cgColor
        layer.borderWidth = 1
    }
    
    private func configureLabel() {
        label = UILabel()
        if UIDevice.Devices.iPhoneSE1stGen {
            label.font = FontFamily.Gotham.medium.font(size: 10)
        }
        label.font = FontFamily.Gotham.medium.font(size: 14)
        label.textAlignment = .center
        
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.centerX.centerY.equalToSuperview()
        }
    }
    
    func bind(buttonLabelText: String) {
        label.text = buttonLabelText
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                if self.traitCollection.userInterfaceStyle == .light {
                    backgroundColor = Colors.orange.color
                    layer.borderColor = Colors.orange.color.cgColor
                    label.textColor = .systemBackground
                } else {
                    layer.borderColor = Colors.orange.color.cgColor
                    backgroundColor = Colors.orange.color
                    label.textColor = .systemBackground
                }
            } else {
                if self.traitCollection.userInterfaceStyle == .light {
                    backgroundColor = .systemBackground
                    layer.borderColor = Colors.statButtonBorderLightMode.color.cgColor
                    label.textColor = .label
                } else {
                    layer.borderColor = Colors.orange.color.cgColor
                    backgroundColor = .systemBackground
                    label.textColor = Colors.orange.color
                }
            }
        }
    }
    
}
