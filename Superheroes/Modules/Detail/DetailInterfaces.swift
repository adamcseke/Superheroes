//
//  DetailInterfaces.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 03..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol DetailWireframeInterface: WireframeInterface {
    func presentAlert(title: String, description: String, buttonText: String, alertImage: UIImage, buttonTwoLabel: String, buttonTwoIsHidden: Bool, delegate: AlertViewDelegate?)
}

protocol DetailViewInterface: ViewInterface {
    func pushHero(_ hero: Heroes)
    func setView(buttonNumber: Int)
    func setNavBarImage(image: String)
    func pushComments(comments: [String])
    func pushCutText(text: String)
}

protocol DetailPresenterInterface: PresenterInterface {
    func powerstatsButtonTapped()
    func characteristicsButtonTapped()
    func commentsButtonTapped()
    func getFavorites()
    func favoritesButtonTapped()
    func commentPushButtonTapped(comment: String, date: Date)
    func getComments()
    func binButtonTapped()
    func checkIfLongText(text: String, delegate: AlertViewDelegate?)
    func buttonCutTapped(range: NSRange, text: String)
    func buttonCancelTapped(range: NSRange, text: String, clipBoardText: String)
}

protocol DetailInteractorInterface: InteractorInterface {
    func isInTheFavorites(entity: Heroes) -> Bool
    func delete(entity: Heroes, completion: BoolCompletition?)
    func insert(entity: Heroes, completion: BoolCompletition?)
    func insertComment(entity: Heroes, comment: String, date: Date, completion: BoolCompletition?)
    func deleteComment(entity: Heroes, completion: BoolCompletition?)
}
