//
//  WinnerLoserView.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 25..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class WinnerLoserView: UIView {
    
    private var winnerLabel: UILabel!
    private var loserLabel: UILabel!
    
    var labelsHidden: Bool = true {
        didSet {
            isHidden = labelsHidden
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
        isHidden = true
        configureWinnerLoser()
    }
    
    private func configureWinnerLoser() {
        winnerLabel = UILabel()
        loserLabel = UILabel()
        
        winnerLabel.text = L10n.FightViewController.Winner.title
        winnerLabel.font = FontFamily.Gotham.bold.font(size: 20)
        winnerLabel.backgroundColor = .systemGreen.withAlphaComponent(0.8)
        winnerLabel.layer.masksToBounds = true
        winnerLabel.layer.cornerRadius = 12
        winnerLabel.textAlignment = .center
        
        loserLabel.text = L10n.FightViewController.Loser.title
        loserLabel.font = FontFamily.Gotham.bold.font(size: 20)
        loserLabel.backgroundColor = .systemRed.withAlphaComponent(0.8)
        loserLabel.layer.masksToBounds = true
        loserLabel.layer.cornerRadius = 12
        loserLabel.textAlignment = .center
        
        addSubview(winnerLabel)
        addSubview(loserLabel)
        
        loserLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(1)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(70)
            
        }
        
        winnerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(1)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
    }
    
    func remakeConstraintWinner(multipliedBy: CGFloat) {
        winnerLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(multipliedBy)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(90)
        }
    }
    
    func remakeConstraintLoser(multipliedBy: CGFloat) {
        loserLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(multipliedBy)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(70)
        }
    }
}
