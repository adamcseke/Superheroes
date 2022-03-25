//
//  FightersView.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 25..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

protocol FightersStackViewDelegate: AnyObject {
    func fighterOneTapped()
    func fighterTwoTapped()
}

class FightersStackView: UIStackView {
    
    weak var delegate: FightersStackViewDelegate?
    
    private var fighterOne: FighterSelectorButton!
    private var fighterTwo: FighterSelectorButton!
    private var fighterOneLifeView: GradientView!
    private var fighterTwoLifeView: GradientView!
    private var fighterOneLifeCounter: UILabel!
    private var fighterTwoLifeCounter: UILabel!
    
    private var healthOriginalHeight: CGFloat = 0.0
    
    var fightersHidden: Bool = false {
        didSet {
            fighterOne.isHidden = fightersHidden
            fighterTwo.isHidden = fightersHidden
        }
    }
    
    var fightersSelected: Bool = false {
        didSet {
            fighterOne.isSelected = fightersSelected
            fighterTwo.isSelected = fightersSelected
        }
    }
    
    var fightersEnabled: Bool = true {
        didSet {
            fighterOne.isEnabled = fightersEnabled
            fighterTwo.isEnabled = fightersEnabled
        }
    }
    
    var fighterOneSelected: Bool = false {
        didSet {
            fighterOne.isSelected = fighterOneSelected
        }
    }
    
    var fighterTwoSelected: Bool = false {
        didSet {
            fighterTwo.isSelected = fighterTwoSelected
        }
    }
    
    var lifeCountViewHidden: Bool = true {
        didSet {
            fighterOneLifeView.isHidden = lifeCountViewHidden
            fighterTwoLifeView.isHidden = lifeCountViewHidden
            fighterOneLifeCounter.isHidden = lifeCountViewHidden
            fighterTwoLifeCounter.isHidden = lifeCountViewHidden
        }
    }
    
    var lifeTitle: String = "" {
        didSet {
            fighterOneLifeCounter.text = lifeTitle
            fighterTwoLifeCounter.text = lifeTitle
        }
    }
    
    var fighterOneLife: String = "" {
        didSet {
            fighterOneLifeCounter.text = fighterOneLife
        }
    }
    
    var fighterTwoLife: String = "" {
        didSet {
            fighterTwoLifeCounter.text = fighterTwoLife
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        axis = .horizontal
        distribution = .equalSpacing
        configureFighters()
        configureFightersLifeCount()
    }
    
    private func configureFighters() {
        fighterOne = FighterSelectorButton()
        fighterTwo = FighterSelectorButton()
        
        fighterOne.isSelected = false
        fighterTwo.isSelected = false
        
        fighterOne.addTarget(self, action: #selector(fighterOneTapped), for: .touchUpInside)
        fighterTwo.addTarget(self, action: #selector(fighterTwoTapped), for: .touchUpInside)
        
        addArrangedSubview(fighterOne)
        addArrangedSubview(fighterTwo)
        
        healthOriginalHeight = 200
        
        fighterOne.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(healthOriginalHeight)
        }
        
        fighterTwo.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(healthOriginalHeight)
        }
    }
    
    @objc private func fighterOneTapped() {
        if let delegate = delegate {
            delegate.fighterOneTapped()
        }
        fighterOne.isSelected.toggle()
        fighterTwo.isSelected = false
    }
    
    @objc private func fighterTwoTapped() {
        if let delegate = delegate {
            delegate.fighterTwoTapped()
        }
        fighterTwo.isSelected.toggle()
        fighterOne.isSelected = false
    }
    
    func setFighterOne(name: String, imageURL: String) {
        fighterOne.bind(name: name, imageURL: imageURL)
    }
    
    func setFighterTwo(name: String, imageURL: String) {
        fighterTwo.bind(name: name, imageURL: imageURL)
    }
    
    private func configureFightersLifeCount() {
        fighterOneLifeView = GradientView()
        fighterTwoLifeView = GradientView()
        fighterOneLifeCounter = UILabel()
        fighterTwoLifeCounter = UILabel()
        
        fighterOneLifeCounter.textColor = .label
        fighterTwoLifeCounter.textColor = .label
        fighterOneLifeCounter.layer.masksToBounds = true
        fighterTwoLifeCounter.layer.masksToBounds = true
        fighterOneLifeCounter.layer.cornerRadius = 8
        fighterTwoLifeCounter.layer.cornerRadius = 8
        fighterOneLifeCounter.backgroundColor = Colors.orange.color.withAlphaComponent(0.8)
        fighterTwoLifeCounter.backgroundColor = Colors.orange.color.withAlphaComponent(0.8)
        fighterOneLifeCounter.textAlignment = .center
        fighterTwoLifeCounter.textAlignment = .center
        fighterOneLifeCounter.font = FontFamily.Gotham.medium.font(size: 16)
        fighterTwoLifeCounter.font = FontFamily.Gotham.medium.font(size: 16)
        
        fighterOneLifeView.layer.cornerRadius = 12
        fighterTwoLifeView.layer.cornerRadius = 12
        fighterOneLifeView.layer.masksToBounds = true
        fighterTwoLifeView.layer.masksToBounds = true
        
        fighterOneLifeView.colors = [UIColor.red.withAlphaComponent(0.5), UIColor.red.withAlphaComponent(0.5), UIColor.black.withAlphaComponent(0.5)]
        fighterTwoLifeView.colors = [UIColor.red.withAlphaComponent(0.5), UIColor.red.withAlphaComponent(0.5), UIColor.black.withAlphaComponent(0.5)]
        
        fighterOne.addSubview(fighterOneLifeView)
        fighterTwo.addSubview(fighterTwoLifeView)
        fighterOne.addSubview(fighterOneLifeCounter)
        fighterTwo.addSubview(fighterTwoLifeCounter)
        
        fighterOneLifeView.snp.makeConstraints { make in
            make.leading.centerX.bottom.equalToSuperview()
            make.height.equalTo(self.healthOriginalHeight)
        }
        
        fighterTwoLifeView.snp.makeConstraints { make in
            make.leading.centerX.bottom.equalToSuperview()
            make.height.equalTo(self.healthOriginalHeight)
        }
        
        fighterOneLifeCounter.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-35)
            make.height.equalTo(20)
        }
        
        fighterTwoLifeCounter.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-35)
            make.height.equalTo(20)
        }
    }
    
    func setFighterOneLife(life: CGFloat) {
        self.fighterOneLifeView.snp.updateConstraints { make in
            make.height.equalTo(self.healthOriginalHeight * life)
        }
    }
    
    func setFighterTwoLife(life: CGFloat) {
        self.fighterTwoLifeView.snp.updateConstraints { make in
            make.height.equalTo(self.healthOriginalHeight * life)
        }
    }
}
