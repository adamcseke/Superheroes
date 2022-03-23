//
//  FighterSelectorButton.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 18..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class FighterSelectorButton: UIButton {
    
    private var heroNameLabel: UILabel!
    private var nameBackgroundView: UIView!
    private var heroImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        layer.cornerRadius = 12
        backgroundColor = Colors.orange.color
        configureImage()
        configureNameBackgroundView()
        configureHeroNameLabel()
    }
    
    private func configureImage() {
        heroImage = UIImageView()
        heroImage.contentMode = .scaleAspectFill
        heroImage.layer.masksToBounds = true
        heroImage.layer.cornerRadius = 12
        addSubview(heroImage)
        
        heroImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureNameBackgroundView() {
        nameBackgroundView = UIView()
        nameBackgroundView.backgroundColor = Colors.gray.color.withAlphaComponent(0.6)
        nameBackgroundView.layer.cornerRadius = 12
        nameBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        addSubview(nameBackgroundView)
        
        nameBackgroundView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(32)
        }
    }
    
    private func configureHeroNameLabel() {
        heroNameLabel = UILabel()
        heroNameLabel.font = UIFont(font: FontFamily.Gotham.medium, size: 18)
        heroNameLabel.textColor = .white
        heroNameLabel.textAlignment = .center
        
        nameBackgroundView.addSubview(heroNameLabel)
        
        heroNameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func bind(name: String, imageURL: String) {
        self.heroNameLabel.text = name
        self.heroImage.sd_setImage(with: URL(string: imageURL))
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = Colors.orange.color.cgColor
                layer.borderWidth = 3
            } else {
                layer.borderColor = UIColor.clear.cgColor
                layer.borderWidth = 0
            }
        }
    }
    
    
}
