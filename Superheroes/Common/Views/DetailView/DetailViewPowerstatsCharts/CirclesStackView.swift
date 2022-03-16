//
//  CirclesStackView.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 10..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class CirclesStackView: UIStackView {
    
    private var circleOne: CircleShapeView!
    private var circleTwo: CircleShapeView!
    private var circleThree: CircleShapeView!
    
    // MARK: Properties
    public var currentProgressCircleOne: Double = 0.0 {
        didSet {
            circleOne.currentProgress = currentProgressCircleOne / 100
        }
    }
    
    public var colorCircleOne: CGColor? {
        didSet {
            circleOne.color = colorCircleOne
        }
    }
    
    public var currentProgressCircleTwo: Double = 0.0 {
        didSet {
            circleTwo.currentProgress = currentProgressCircleTwo / 100
        }
    }
    
    public var colorCircleTwo: CGColor? {
        didSet {
            circleTwo.color = colorCircleTwo
        }
    }
    
    public var currentProgressCircleThree: Double = 0.0 {
        didSet {
            circleThree.currentProgress = currentProgressCircleThree / 100
        }
    }
    
    public var colorCircleThree: CGColor? {
        didSet {
            circleThree.color = colorCircleThree
        }
    }
    
    public var titleCircleOne: String = "" {
        didSet {
            circleOne.title = titleCircleOne
        }
    }

    public var titleCircleTwo: String = "" {
        didSet {
            circleTwo.title = titleCircleTwo
        }
    }
    
    public var titleCircleThree: String = "" {
        didSet {
            circleThree.title = titleCircleThree
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
        spacing = 15
        distribution = .fillEqually
        configureCirclesView()
    }
    
    private func configureCirclesView() {
        circleOne = CircleShapeView()
        circleTwo = CircleShapeView()
        circleThree = CircleShapeView()
        
        addArrangedSubview(circleOne)
        addArrangedSubview(circleTwo)
        addArrangedSubview(circleThree)
        
        circleOne.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.width.equalTo(80)
        }
    }
}
