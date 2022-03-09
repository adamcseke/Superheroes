//
//  GradientView.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 08..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class GradientView: UIView {

    // Default Colors
    var colors: [UIColor] = [UIColor(white: 0.0, alpha: 0.0), UIColor.black.withAlphaComponent(1.0)]

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Must be set when the rect is drawn
        setGradient(color1: colors[0], color2: colors[1], rect: rect)
    }

    func setGradient(color1: UIColor, color2: UIColor, rect: CGRect) {
        layoutIfNeeded()
        let context = UIGraphicsGetCurrentContext()
        let colours = [color1.cgColor, color2.cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colours, locations: [0.0, 1])
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
        context?.saveGState()
        path.addClip()
        // swiftlint:disable force_unwrapping
        context?.drawLinearGradient(gradient!, start: CGPoint(x: rect.width / 2, y: -50), end: CGPoint(x: rect.width / 2, y: frame.height), options: CGGradientDrawingOptions())
        // swiftlint:enable force_unwrapping
        context?.restoreGState()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Ensure view has a transparent background color (not required)
        backgroundColor = UIColor.clear
    }

}
