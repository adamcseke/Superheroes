//
//  FavoritesViewController.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 02..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Lottie
import TBEmptyDataSet
import UIKit

final class FavoritesViewController: UIViewController {

    private let generator = UIImpactFeedbackGenerator(style: .medium)
    private var searchVC: UISearchController!
    private var collectionView: UICollectionView!
    private var emptyAnimationView: AnimationView!
    
    private let statusBarFrame = UIApplication.shared.statusBarFrame
    private var statusBarView: UIView!
    
    // MARK: - Public properties -

    var presenter: FavoritesPresenterInterface!

    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        statusBarView = UIView()
        statusBarView.frame = statusBarFrame
        self.view.addSubview(statusBarView)
        self.statusBarView.frame = self.statusBarFrame
        self.statusBarView.backgroundColor = UIColor.systemBackground
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        presenter.getFavorites()
        presenter.viewWillAppear(animated: true)
        configureNotificationCenter()
        emptyAnimationView.play()
    }
    
    private func setup() {
        configureViewController()
        setupNavigationController()
        configureCollectionView()
        setupEmptyAnimation()
        configureSearchController()
    }
    
    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
   
    @objc func applicationDidBecomeActive(notification: Notification) {
        emptyAnimationView.play()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.isOpaque = false
        navigationController?.navigationBar.backgroundColor = .clear
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    private func configureCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        
        let width =  view.bounds.width
        let availableWidth = width - 50
        let itemWidth = availableWidth / 2.1
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 90)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SearchedCollectionViewCell.self, forCellWithReuseIdentifier: "searchedCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.tabBarController?.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true
        collectionView.emptyDataSetDataSource = self
        collectionView.emptyDataSetDelegate = self
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupEmptyAnimation() {
        emptyAnimationView = AnimationView(name: "empty")
        emptyAnimationView.isHidden = true
        emptyAnimationView.frame = view.bounds
        emptyAnimationView.contentMode = .scaleAspectFit
        emptyAnimationView.loopMode = .loop
        emptyAnimationView.animationSpeed = 1
        emptyAnimationView.backgroundColor = .clear
        emptyAnimationView.play()
        view.addSubview(emptyAnimationView)
        
        emptyAnimationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.3)
        }
    }
    
    private func configureSearchController() {
        searchVC = UISearchController(searchResultsController: nil)
        searchVC.hidesNavigationBarDuringPresentation = true
        searchVC.searchBar.sizeToFit()
        searchVC.searchBar.autocorrectionType = .no
        searchVC.searchBar.placeholder = L10n.SearchViewController.SearchBar.placeholder
        searchVC.automaticallyShowsCancelButton = true
        searchVC.obscuresBackgroundDuringPresentation = true
        searchVC.searchBar.tintColor = Colors.orange.color
        searchVC.searchBar.delegate = self
        navigationItem.searchController = searchVC
    }
}

// MARK: - Extensions -

extension FavoritesViewController: FavoritesViewInterface {
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHero = presenter.cellForItem(at: indexPath)
        presenter.pushToDetails(hero: selectedHero)
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItem(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchedCell", for: indexPath) as? SearchedCollectionViewCell else {
            return UICollectionViewCell()
        }
        let hero = presenter.cellForItem(at: indexPath)
        let heroViewModel = HeroViewModel(hero: hero)
        cell.bind(hero: heroViewModel, indexPath: indexPath, delegate: self, isFavorite: hero.isFavorite)
        return cell
    }
}

extension FavoritesViewController: TBEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(in scrollView: UIScrollView) -> Bool {
        if presenter.numberOfItem(in: 1) == 0 {
            emptyAnimationView.isHidden = false
        } else {
            emptyAnimationView.isHidden = true
        }
        return presenter.numberOfItem(in: 1) == 0
    }
}

extension FavoritesViewController: TBEmptyDataSetDataSource {
    
    func customViewForEmptyDataSet(in scrollView: UIScrollView) -> UIView? {
        let view = EmptyView(frame: scrollView.frame)
        view.bind(text: L10n.FavoritesViewController.EmptyStateView.label)
        return view
    }
}

extension FavoritesViewController: SearchedCellDelegate {
    func buttonTapped(at indexPath: IndexPath) {
        generator.impactOccurred()
        presenter.favoritesButtonTapped(indexPath: indexPath)
    }
    
}

extension FavoritesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchButtonTapped(name: searchBar.text ?? "")
        reloadCollectionView()
        searchVC.dismiss(animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchButtonTapped(name: searchBar.text ?? "")
        searchVC.dismiss(animated: true)
        self.collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchButtonTapped(name: searchBar.text ?? "")
        self.reloadCollectionView()
    }
}

extension FavoritesViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            if collectionView.contentOffset.y > -168 {
                let actualHeight = collectionView.contentOffset.y - (collectionView.contentOffset.y + 168)
                collectionView.setContentOffset(CGPoint(x: 0, y: actualHeight), animated: true)
            }
        }
    }
}
