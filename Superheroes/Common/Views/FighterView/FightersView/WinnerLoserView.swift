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
    
    private var winnerLabel: WinnerLoserLabel!
    private var loserLabel: WinnerLoserLabel!
    
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
        winnerLabel = WinnerLoserLabel()
        loserLabel = WinnerLoserLabel()
        
        winnerLabel.text = L10n.FightViewController.Winner.title
        winnerLabel.backgroundColor = .systemGreen.withAlphaComponent(0.8)
        
        loserLabel.text = L10n.FightViewController.Loser.title
        loserLabel.backgroundColor = .systemRed.withAlphaComponent(0.8)
        
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
