//
//  NSTextAttachment.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 09..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

extension NSTextAttachment {
    func setImageHeight(height: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height

        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * height, height: height)
    }
}
