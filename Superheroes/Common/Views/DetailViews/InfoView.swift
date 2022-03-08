//
//  InfoView.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 07..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class InfoView: UIView {
    
    private var titleLabel: UILabel!
    private var infoLabel: UILabel!
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var info: String? {
        didSet {
            infoLabel.text = info
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.userInterfaceStyle == .light {
            titleLabel.textColor = Colors.statButtonLabelLightMode.color
            infoLabel.textColor = Colors.infoLabel.color
        } else {
            titleLabel.textColor = Colors.orange.color
            infoLabel.textColor = .white
        }
        
    }
    
    private func setup() {
        configureView()
        configureTitleLabel()
        configureInfoLabel()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        if  UIDevice.Devices.iPhoneSE1stGen {
            titleLabel.font = FontFamily.Gotham.medium.font(size: 14)
        } else {
            titleLabel.font = FontFamily.Gotham.medium.font(size: 18)
        }
        
        if self.traitCollection.userInterfaceStyle == .light {
            titleLabel.textColor = Colors.statButtonLabelLightMode.color
        } else {
            titleLabel.textColor = Colors.orange.color
        }
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(12)
        }
    }
    
    private func configureInfoLabel() {
        infoLabel = UILabel()
        infoLabel.numberOfLines = 0
        if self.traitCollection.userInterfaceStyle == .light {
            infoLabel.textColor = Colors.infoLabel.color
        } else {
            infoLabel.textColor = .white
        }
        
        infoLabel.font = FontFamily.Gotham.book.font(size: 13)
        addSubview(infoLabel)
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(1.5)
            make.trailing.equalToSuperview()
        }
    }
    
    func bind(titleLabelText: String, infoLabelText: String) {
        titleLabel.text = titleLabelText
        infoLabel.text = infoLabelText
    }
    
}
