//
//  EmptyView.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 02..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    private var emptyImageView: UIImageView!
    private var emptyLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        configureEmptyLabel()
    }
    
    private func configureEmptyLabel() {
        emptyLabel = UILabel()
        emptyLabel.numberOfLines = 0
        emptyLabel.font = FontFamily.Gotham.medium.font(size: 18)
        emptyLabel.textColor = .label
        emptyLabel.textAlignment = .center
        
        addSubview(emptyLabel)
        
        emptyLabel.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    func bind(text: String) {
        emptyLabel.text = text
    }
}
