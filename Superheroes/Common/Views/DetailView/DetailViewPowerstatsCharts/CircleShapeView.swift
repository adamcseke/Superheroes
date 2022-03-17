//
//  CircleShapeView.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 10..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class CircleShapeView: UIView {
    
    private var progressShape: CAShapeLayer!
    private var precentageLabel: UILabel!
    private var titleLabel: UILabel!
    private var trackShape: CAShapeLayer!
    
    // MARK: Properties
    public var currentProgress: Double = 0.0 {
        didSet {
            let precentage = currentProgress * 100
            progressShape.strokeEnd = currentProgress
            precentageLabel.text = "\(Int(precentage))%"
            setupAnimation()
            setNeedsLayout()
        }
    }
    
    public var color: CGColor? {
        didSet {
            progressShape.strokeColor = color
            setNeedsLayout()
        }
    }
    
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
      super.draw(rect)
        trackShape.position = CGPoint(x: self.layer.bounds.midX, y: self.layer.bounds.midY)
        progressShape.position = CGPoint(x: self.layer.bounds.midX, y: self.layer.bounds.midY)
    }
    
    private func setup() {
        configureShapeLayer()
        configurePrecentageLabel()
        configureTitleLabel()
    }
    
    private func configureShapeLayer() {
        progressShape = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: center, radius: 48, startAngle: -(.pi / 2), endAngle: 3 * .pi / 2, clockwise: true)
        trackShape = CAShapeLayer()
        trackShape.path = circlePath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 8
        trackShape.strokeColor = Colors.orange.color.cgColor
        layer.addSublayer(trackShape)
        
        progressShape.path = circlePath.cgPath
        progressShape.strokeColor = color
        progressShape.strokeEnd = 0
        progressShape.fillColor = UIColor.clear.cgColor
        progressShape.lineWidth = 16
        progressShape.lineCap = .round
        layer.addSublayer(progressShape)
    }
    
    private func setupAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = currentProgress
        animation.duration = 0.6
        animation.fromValue = 0
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        progressShape.add(animation, forKey: "animation")
    }
    
    private func configurePrecentageLabel() {
        precentageLabel = UILabel()
        precentageLabel.textAlignment = .center
        precentageLabel.font = FontFamily.Gotham.medium.font(size: 12)
        precentageLabel.sizeToFit()
        addSubview(precentageLabel)
        precentageLabel.snp.makeConstraints { make in
            make.top.centerY.centerX.equalToSuperview()
        }
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.font = FontFamily.Gotham.medium.font(size: 12)
        titleLabel.sizeToFit()
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
