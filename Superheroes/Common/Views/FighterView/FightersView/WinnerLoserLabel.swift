//
//  WinnerLoserLabel.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 04. 05..
//  Copyright © 2022. levivig. All rights reserved.
//

import PaddingLabel
import UIKit

class WinnerLoserLabel: PaddingLabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        font = FontFamily.Gotham.bold.font(size: 20)
        layer.masksToBounds = true
        layer.cornerRadius = 12
        textAlignment = .center
        leftInset = 10
        rightInset = 10
        topInset = 5
        bottomInset = 5
    }
}
