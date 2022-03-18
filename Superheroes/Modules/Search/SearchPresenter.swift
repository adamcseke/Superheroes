//
//  SearchPresenter.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 02..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class SearchPresenter {
    
    // MARK: - Private properties -
    
    private unowned let view: SearchViewInterface
    private let interactor: SearchInteractorInterface
    private let wireframe: SearchWireframeInterface
    
    private var heroes: [Heroes] = []
    private var text: String = ""
    private var isFavorite: Bool = false
    private var favorites: [Heroes] = []
    
    // MARK: - Lifecycle -
    
    init(
        view: SearchViewInterface,
        interactor: SearchInteractorInterface,
        wireframe: SearchWireframeInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func viewWillAppear(animated: Bool) {
        self.getFavorites()
    }
}

// MARK: - Extensions -

extension SearchPresenter: SearchPresenterInterface {

    func getFavorites() {
        favorites = DatabaseManager.main.getHeroes()
        heroes.enumerated().forEach({ index, hero in
            var newHero = heroes[index]
            if favorites.first(where: {$0.id == hero.id}) != nil {
                newHero.isFavorite = true
            } else {
                newHero.isFavorite = false
            }
            heroes[index] = newHero
        })
    }
    
    func favoritesButtonTapped(indexPath: IndexPath) {
        heroes[indexPath.row].isFavorite.toggle()
        isFavorite = interactor.isInTheFavorites(entity: heroes[indexPath.row])
        heroes.forEach { hero in
            if hero.isFavorite == true && !favorites.contains(where: { $0 == hero }) {
                favorites.append(hero)
            } else if hero.isFavorite == false {
                favorites.removeAll(where: { $0 == hero })
            }
        }

        if self.isFavorite {
            interactor.delete(entity: heroes[indexPath.row]) { _ in
                self.isFavorite = false
            }
        } else {
            interactor.insert(entity: heroes[indexPath.row]) { _ in
                self.isFavorite = true
            }
        }
        
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfItem(in section: Int) -> Int {
        heroes.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> Heroes {
        return heroes[indexPath.row]
    }
    
    func searchVCDismissed() {
        heroes.removeAll()
        self.view.reloadCollectionView()
    }
    
    func pushToDetails(hero: Heroes) {
        wireframe.pushToDetails(hero: hero)
    }
    
    func searchButtonTapped(name: String) {
        text = name
        if text.isEmpty {
            return
        }
        search(name: text)
    }
    
    private func search(name: String) {
        interactor.getSuperheroes(name: name) { result in
            switch result {
                
            case .success(let heroes):
                
                self.heroes = heroes.results
                self.getFavorites()
                self.view.reloadCollectionView()
                
            case .failure(let error):
//                self.wireframe.presentAlert(title: "Test", description: "test", buttonText: "Ok", alertImage: UIImage(named: Images.noSignal.name)?.withTintColor(Colors.orange.color) ?? UIImage())
                print(error.localizedDescription)
            }
        }
    }
    
}
