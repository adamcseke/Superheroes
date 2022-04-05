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
    
    private var itemHeight: CGFloat = 0.0
    
    var fightersHidden: Bool = false {
        didSet {
            fighterOne.isHidden = fightersHidden
            fighterTwo.isHidden = fightersHidden
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
    }
    
    @objc private func fighterOneTapped() {
        delegate?.fighterOneTapped()
        if fighterOneSelected {
            fighterOne.layer.borderColor = Colors.orange.color.cgColor
            fighterOne.layer.borderWidth = 2
        } else {
            fighterOne.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @objc private func fighterTwoTapped() {
        delegate?.fighterTwoTapped()

        if fighterTwoSelected {
            fighterTwo.layer.borderColor = Colors.orange.color.cgColor
            fighterTwo.layer.borderWidth = 2
        } else {
            fighterOne.layer.borderColor = UIColor.clear.cgColor
        }
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
            make.height.equalTo(itemHeight * life)
        }
    }
    
    func setFighterTwoLife(life: CGFloat) {
        self.fighterTwoLifeView.snp.updateConstraints { make in
            make.height.equalTo(itemHeight * life)
        }
    }
    
    func setFightersConstraints(width: CGFloat, height: CGFloat) {
        itemHeight = height
        
        fighterOne.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        fighterTwo.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        fighterOneLifeView.snp.makeConstraints { make in
            make.leading.centerX.bottom.equalToSuperview()
            make.height.equalTo(height)
        }
        
        fighterTwoLifeView.snp.makeConstraints { make in
            make.leading.centerX.bottom.equalToSuperview()
            make.height.equalTo(height)
        }
    }
}
