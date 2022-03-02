//
//  ViewControllerPreview.swift
//
//  Created by Levente Vig on 2021. 07. 31..
//

import SwiftUI
import UIKit

@available(iOS 13.0, *)
struct ViewControllerPreview: UIViewControllerRepresentable {
    
    let viewControllerGenerator: () -> UIViewController

    init(_ viewControllerGenerator: @escaping () -> UIViewController) {
        self.viewControllerGenerator = viewControllerGenerator
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        return viewControllerGenerator()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
