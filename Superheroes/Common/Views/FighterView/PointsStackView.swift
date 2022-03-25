//
//  PointsStackView.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 25..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class PointsStackView: UIStackView {
    
    private var pointsLabel: UILabel!
    private var circleOne: CircleShapeView!
    private var circleTwo: CircleShapeView!
    
    public var currentProgressOne: Double = 0.0 {
        didSet {
            circleOne.currentProgress = currentProgressOne
        }
    }
    
    public var currentProgressTwo: Double = 0.0 {
        didSet {
            circleTwo.currentProgress = currentProgressTwo
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
        distribution = .equalSpacing
        axis = .horizontal
        configureCircleOne()
        configurePointsLabel()
        configureCircleTwo()
    }
    
    private func configureCircleOne() {
        circleOne = CircleShapeView()
        circleOne.radius = 30
        circleOne.color = UIColor.blue.cgColor
        
        addArrangedSubview(circleOne)
        
        circleOne.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
    }
    
    private func configurePointsLabel() {
        pointsLabel = UILabel()
        pointsLabel.text = L10n.FightViewController.Points.title
        
        addArrangedSubview(pointsLabel)
    }
    
    private func configureCircleTwo() {
        circleTwo = CircleShapeView()
        circleTwo.radius = 30
        addArrangedSubview(circleTwo)
        circleTwo.color = UIColor.red.cgColor
        
        circleTwo.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
    }
    
}
