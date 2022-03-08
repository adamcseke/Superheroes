//
//  CharacteristicsView.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 07..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class CharacteristicsView: UIStackView {
    
    var title: String? {
        didSet {
            sectionTitleLabel.text = title
        }
    }
    
    private var sectionTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.userInterfaceStyle == .light {
            sectionTitleLabel.textColor = Colors.sectionTitleLightMode.color
        } else {
            sectionTitleLabel.textColor = Colors.orange.color
        }
    }
    
    private func setup() {
        axis = .vertical
        spacing = 4
        distribution = .equalSpacing
        configureSectionTitle()
    }
    
    private func configureSectionTitle() {
        sectionTitleLabel = UILabel()
        if self.traitCollection.userInterfaceStyle == .light {
            sectionTitleLabel.textColor = Colors.sectionTitleLightMode.color
        } else {
            sectionTitleLabel.textColor = Colors.orange.color
        }
        sectionTitleLabel.font = FontFamily.Gotham.bold.font(size: 20)
        addArrangedSubview(sectionTitleLabel)
    }
    
    func addItem(title: String, info: String) {
        let infoView = InfoView()
        infoView.bind(titleLabelText: title, infoLabelText: info)
        addArrangedSubview(infoView)
    }
}
