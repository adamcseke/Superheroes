//
//  UIView+Ext.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 18..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
