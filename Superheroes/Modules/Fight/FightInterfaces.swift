//
//  FightInterfaces.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 14..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol FightWireframeInterface: WireframeInterface {
    func presentAlert(title: String, description: String, buttonText: String, alertImage: UIImage)
}

protocol FightViewInterface: ViewInterface {
    func reloadCollectionView()
    func pushFavoriteHeroes(heroes: [Heroes])
    func setSelectedFighter(hero: Heroes)
    func setHeroTwoLife(life: Double)
    func setHeroOneLife(life: Double)
    func timerStopped()
    func pushHeroOneLife()
    func pushHeroTwoLife()
}

protocol FightPresenterInterface: PresenterInterface {
    func numberOfSections() -> Int
    func numberOfItem(in section: Int) -> Int
    func cellForItem(at indexPath: IndexPath) -> Heroes
    func getFavorites()
    func setTwoHeroesToFight()
    func setSelectedHero(hero: Heroes)
    func fightButtonTapped(heroOne: Heroes, heroTwo: Heroes)
    func stopTimers()
}

protocol FightInteractorInterface: InteractorInterface {
    func isInTheFavorites(entity: Heroes) -> Bool
}
