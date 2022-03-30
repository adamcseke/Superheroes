//
//  WinnerLoserView.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 25..
//  Copyright © 2022. levivig. All rights reserved.
//

import PaddingLabel
import UIKit

class WinnerLoserView: UIView {
    
    private var winnerLabel: PaddingLabel!
    private var loserLabel: PaddingLabel!
    
    var topInset: CGFloat = 5.0
    var bottomInset: CGFloat = 5.0
    var leftInset: CGFloat = 5.0
    var rightInset: CGFloat = 5.0
    
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
        winnerLabel = PaddingLabel()
        loserLabel = PaddingLabel()
        
        winnerLabel.text = L10n.FightViewController.Winner.title
        winnerLabel.font = FontFamily.Gotham.bold.font(size: 20)
        winnerLabel.backgroundColor = .systemGreen.withAlphaComponent(0.8)
        winnerLabel.layer.masksToBounds = true
        winnerLabel.layer.cornerRadius = 12
        winnerLabel.textAlignment = .center
        winnerLabel.leftInset = 10
        winnerLabel.rightInset = 10
        winnerLabel.topInset = 5
        winnerLabel.bottomInset = 5
        
        loserLabel.text = L10n.FightViewController.Loser.title
        loserLabel.font = FontFamily.Gotham.bold.font(size: 20)
        loserLabel.backgroundColor = .systemRed.withAlphaComponent(0.8)
        loserLabel.layer.masksToBounds = true
        loserLabel.layer.cornerRadius = 12
        loserLabel.textAlignment = .center
        loserLabel.leftInset = 10
        loserLabel.rightInset = 10
        loserLabel.topInset = 5
        loserLabel.bottomInset = 5
        
        addSubview(winnerLabel)
        addSubview(loserLabel)
        
        loserLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(1)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
        }
        
        winnerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(1)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
        }
    }
    
    func remakeConstraintWinner(multipliedBy: CGFloat) {
        winnerLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(multipliedBy)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
        }
    }
    
    func remakeConstraintLoser(multipliedBy: CGFloat) {
        loserLabel.snp.remakeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(multipliedBy)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
        }
    }
}
