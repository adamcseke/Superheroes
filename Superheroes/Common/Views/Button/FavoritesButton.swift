//
//  FavoritesButton.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 14..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class FavoritesButton: UIButton {

    private var buttonLabel: UILabel!
    private var emptyStarStr = NSMutableAttributedString()
    private var filledStarStr = NSMutableAttributedString()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        configureButton()
        configureLabel()
    }
    
    private func configureButton() {
        layer.cornerRadius = 11
        isUserInteractionEnabled = true
        
        snp.makeConstraints { make in
            make.height.width.equalTo(37)
        }
        isSelected = false
    }
    
    private func configureLabel() {
        buttonLabel = UILabel()
        buttonLabel.textAlignment = .center
        buttonLabel.font = .systemFont(ofSize: 20)
        
        let emptyStar = NSTextAttachment()
        emptyStar.image = UIImage(asset: Images.starEmpty)
        emptyStar.setImageHeight(height: 22)
        emptyStarStr = NSMutableAttributedString(attachment: emptyStar)
        
        let filledStar = NSTextAttachment()
        filledStar.image = UIImage(asset: Images.starFill)
        filledStar.setImageHeight(height: 22)
        filledStarStr = NSMutableAttributedString(attachment: filledStar)
        
        if isSelected {
            setAttributedTitle(filledStarStr, for: .selected)
        } else {
            setAttributedTitle(emptyStarStr, for: .normal)
        }
        
        addSubview(buttonLabel)
        
        buttonLabel.snp.makeConstraints { make in
            make.leading.centerX.centerY.equalToSuperview()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setAttributedTitle(filledStarStr, for: .selected)
            } else {
                setAttributedTitle(emptyStarStr, for: .normal)
            }
        }
    }

}
