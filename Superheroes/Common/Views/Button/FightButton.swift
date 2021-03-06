//
//  FightButton.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 28..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class FightButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = Colors.orange.color
            } else {
                backgroundColor = Colors.orange.color.withAlphaComponent(0.5)
            }
        }
    }
    
    private func setup() {
        titleLabel?.font = FontFamily.Gotham.medium.font(size: 18)
        backgroundColor = Colors.orange.color
        setTitleColor(.systemBackground, for: .normal)
        layer.cornerRadius = 12
        isEnabled = true
        snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}
