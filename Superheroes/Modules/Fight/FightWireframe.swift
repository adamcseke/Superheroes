//
//  FightWireframe.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 14..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class FightWireframe: BaseWireframe {

    // MARK: - Module setup -

    init() {
        let moduleViewController = FightViewController()
        super.init(viewController: moduleViewController)
        
        let interactor = FightInteractor()
        let presenter = FightPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension FightWireframe: FightWireframeInterface {
    func presentAlert(title: String, description: String, buttonText: String, alertImage: UIImage) {
            let alertVC = AlertViewController(title: title, message: description, buttonLabel: buttonText, alertImage: alertImage)
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.modalPresentationStyle = .overFullScreen
            navigationController?.present(alertVC, animated: true)
        }
}
