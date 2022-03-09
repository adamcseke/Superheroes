//
//  SearchedCollectionViewCell.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 02..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

protocol SearchedCellDelegate: AnyObject {
    func buttonTapped(at indexPath: IndexPath)
}

class SearchedCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: SearchedCellDelegate?
    private var indexPath: IndexPath?

    private var heroNameLabel: UILabel!
    private var nameBackgroundView: UIView!
    private var cellBackgroundImageView: UIImageView!
    private var saveButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        configureCellBackgroundView()
        configureNameBackgroundView()
        configureHeroNameLabel()
        configureSaveButton()
    }
    
    private func configureCellBackgroundView() {
        cellBackgroundImageView = UIImageView()
        cellBackgroundImageView.image = UIImage(named: "cellBackgroundImage")
        cellBackgroundImageView.contentMode = .scaleAspectFill
        cellBackgroundImageView.layer.cornerRadius = 12
        cellBackgroundImageView.layer.masksToBounds = true
        
        contentView.addSubview(cellBackgroundImageView)
        
        cellBackgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func configureNameBackgroundView() {
        nameBackgroundView = UIView()
        nameBackgroundView.backgroundColor = Colors.gray.color.withAlphaComponent(0.6)
        
        cellBackgroundImageView.addSubview(nameBackgroundView)
        
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
    
    private func configureSaveButton() {
        saveButton = UIButton()
        
        let filledStar = NSTextAttachment()
        filledStar.image = UIImage(asset: Images.starFill)
        filledStar.setImageHeight(height: 22)
        let filledStarStr = NSMutableAttributedString(attachment: filledStar)
        
        let emptyStar = NSTextAttachment()
        emptyStar.image = UIImage(asset: Images.starEmpty)
        emptyStar.setImageHeight(height: 22)
        let emptyStarStr = NSMutableAttributedString(attachment: emptyStar)
        
        saveButton.setAttributedTitle(emptyStarStr, for: .normal)
        saveButton.setAttributedTitle(filledStarStr, for: .selected)

        saveButton.layer.backgroundColor = Colors.saveButtonBackground.color.cgColor
        saveButton.layer.cornerRadius = 17.5
        saveButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        contentView.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.width.equalTo(35)
        }
    }
    
    @objc func buttonTapped() {
        saveButton.isSelected.toggle()
        if let indexPath = indexPath, let delegate = delegate {
            delegate.buttonTapped(at: indexPath)
        }
        
        UIView.animate(withDuration: 0.05,
            animations: {
                self.saveButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.saveButton.transform = CGAffineTransform.identity
                }
            })
    }
    
    func bind(
              nameLabel: String,
              backgroundImageURL: String,
              indexPath: IndexPath,
              delegate: SearchedCellDelegate?
    ) {
        heroNameLabel.text = nameLabel
        cellBackgroundImageView.sd_setImage(with: URL(string: backgroundImageURL), placeholderImage: Images.superhero.image.withTintColor(UIColor.label))
        self.indexPath = indexPath
        self.delegate = delegate
    }
}
