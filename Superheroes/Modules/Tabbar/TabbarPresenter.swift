//
//  TabbarPresenter.swift
//  citychat
//
//  Created by Levente Vig on 2019. 07. 12..
//  Copyright (c) 2019. CodeYard. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class TabbarPresenter: NSObject {
    
    // MARK: - Public properties -

    // MARK: - Private properties -

    private unowned let view: TabbarViewInterface
    private let interactor: TabbarInteractorInterface
    private let wireframe: TabbarWireframeInterface
    private var selectedTab: Int = 0

    // MARK: - Lifecycle -

    init(view: TabbarViewInterface, interactor: TabbarInteractorInterface, wireframe: TabbarWireframeInterface, selectedTab: Int) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.selectedTab = selectedTab
    }
}

// MARK: - Extensions -

extension TabbarPresenter: TabbarPresenterInterface {
    
    func viewDidLoad() {
        view.set(controllers: setupViewControllers())
        view.select(tab: selectedTab)
        setup()
        
    }
    
    private func setup() {
        UITabBar.appearance().barTintColor = .systemBackground
        UITabBar.appearance().tintColor = Colors.orange.color
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
    }
    
    func setupViewControllers() -> [UIViewController] {
        let controllers: [UIViewController] = [
            createSearchNC(),
            createFavoritesNC(),
            createProfileNC()
        ]
        
        return controllers
    }
    
    private func createSearchNC() -> NavigationViewController {
        let searchVC = SearchWireframe().viewController
        searchVC.title = L10n.TabBarViewController.Search.TabBarItem.title
        searchVC.tabBarItem = UITabBarItem(title: L10n.TabBarViewController.Search.TabBarItem.title, image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return NavigationViewController(rootViewController: searchVC)
    }
    
    private func createFavoritesNC() -> NavigationViewController {
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: L10n.TabBarViewController.Favorites.TabBarItem.title, image: UIImage(systemName: "star.fill"), tag: 1)
        return NavigationViewController(rootViewController: favoritesVC)
    }
    
    private func createProfileNC() -> NavigationViewController {
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: L10n.TabBarViewController.Profile.TabBarItem.title, image: UIImage(systemName: "person.fill"), tag: 2)
        return NavigationViewController(rootViewController: profileVC)
    }
}
