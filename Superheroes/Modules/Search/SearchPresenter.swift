//
//  SearchPresenter.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 02..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class SearchPresenter {

    // MARK: - Private properties -

    private unowned let view: SearchViewInterface
    private let interactor: SearchInteractorInterface
    private let wireframe: SearchWireframeInterface
    
    private var heroes: [Heroes] = []
    private var text: String = ""

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
}

// MARK: - Extensions -

extension SearchPresenter: SearchPresenterInterface {
    func pushToDetails(hero: Heroes) {
        wireframe.pushToDetails(hero: hero)
    }
    
    func didTapOnCell(hero: Heroes) {
        pushToDetails(hero: hero)
    }
    
    func searchButtonTapped(name: String) {
        text = name
        if text.isEmpty {
            return
        }
        search(name: text)
    }
    
    func getSuperHeroes() -> [Heroes] {
        heroes
    }
    
    private func search(name: String) {
        interactor.getSuperheroes(name: name) { result in
            switch result {
                
            case .success(let heroes):
                
                self.heroes = heroes.results
                
                self.view.reloadCollectionView()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
