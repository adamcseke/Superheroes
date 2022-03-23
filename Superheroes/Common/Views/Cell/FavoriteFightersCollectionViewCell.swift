//
//  FavoriteFightersCollectionViewCell.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 21..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class FavoriteFightersCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "favoriteFightersCell"
    
    private var heroNameLabel: UILabel!
    private var nameBackgroundView: UIView!
    private var cellBackgroundImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        configureCellBackgroundView()
        configureNameBackgroundView()
        configureHeroNameLabel()
    }
    
    private func configureCellBackgroundView() {
        cellBackgroundImageView = UIImageView()
        cellBackgroundImageView.backgroundColor = .red
        cellBackgroundImageView.contentMode = .scaleAspectFill
        cellBackgroundImageView.layer.cornerRadius = 12
        cellBackgroundImageView.layer.masksToBounds = true
        
        contentView.addSubview(cellBackgroundImageView)
        
        cellBackgroundImageView.snp.makeConstraints { make in
            make.top.leading.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func configureNameBackgroundView() {
        nameBackgroundView = UIView()
        nameBackgroundView.backgroundColor = Colors.gray.color.withAlphaComponent(0.6)
        
        cellBackgroundImageView.addSubview(nameBackgroundView)
        
        nameBackgroundView.snp.makeConstraints { make in
            make.bottom.leading.centerX.equalToSuperview()
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
            make.leading.centerX.equalToSuperview()
        }
    }
    
    func bind(hero: SearchedCollectionViewCellBindable) {
        self.heroNameLabel.text = hero.name
        self.cellBackgroundImageView.sd_setImage(with: URL(string: hero.image.url))
    }
    
}
