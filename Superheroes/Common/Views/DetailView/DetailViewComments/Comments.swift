//
//  Comments.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 22..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class Comments: UIView {
    
    private let label = UILabel()
    var text: String? {
        didSet {
            label.text = text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        configureView()
        configureLabel()
    }
    
    private func configureView() {
        layer.cornerRadius = 12
        backgroundColor = Colors.orange.color
    }
    
    private func configureLabel() {
        label.font = FontFamily.Gotham.book.font(size: 12)
        label.textColor = .systemBackground
        label.numberOfLines = 0
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
