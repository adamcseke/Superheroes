//
//  SearchViewController.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 02..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import TBEmptyDataSet
import UIKit

final class SearchViewController: UIViewController {
    
    private let generator = UIImpactFeedbackGenerator(style: .medium)
    private let statusBarFrame = UIApplication.shared.statusBarFrame
    private var statusBarView: UIView!
    
    private var searchVC: UISearchController!
    private var collectionView: UICollectionView!
    private let itemsPerRow: CGFloat = 2
    private var selectedHero: Heroes?
    private var saveButtonImage: NSAttributedString?
    
    // MARK: - Public properties -
    
    var presenter: SearchPresenterInterface!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
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
        tabBarController?.tabBar.isHidden = false
        presenter.viewWillAppear(animated: true)
        self.reloadCollectionView()
    }
    
    private func setup() {
        setupNavigationController()
        configureViewController()
        configureSearchController()
        configureCollectionView()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.isOpaque = false
        navigationController?.navigationBar.backgroundColor = .clear
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
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
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true
        collectionView.emptyDataSetDataSource = self
        collectionView.emptyDataSetDelegate = self
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Extensions -

extension SearchViewController: SearchViewInterface {
    func setSearchbarTextClear() {
        searchVC.searchBar.text = ""
    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHero = presenter.cellForItem(at: indexPath)
        presenter.pushToDetails(hero: selectedHero)
    }
    
}

extension SearchViewController: UICollectionViewDataSource {
    
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
        let heroesInfo = presenter.cellForItem(at: indexPath)
        let heroViewModel = HeroViewModel(hero: heroesInfo)
        cell.bind(hero: heroViewModel, indexPath: indexPath, delegate: self, isFavorite: heroesInfo.isFavorite)
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchButtonTapped(name: searchBar.text ?? "")
        searchVC.dismiss(animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchVCDismissed()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.reloadCollectionView()
    }
}

extension SearchViewController: TBEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(in scrollView: UIScrollView) -> Bool {
        return presenter.numberOfItem(in: 1) == 0
    }
}

extension SearchViewController: TBEmptyDataSetDataSource {
    
    func customViewForEmptyDataSet(in scrollView: UIScrollView) -> UIView? {
        view.layoutIfNeeded()
        let view = EmptyView(frame: scrollView.frame)
        view.bind(text: L10n.SearchViewController.EmptyStateView.label)
        return view
    }
}

extension SearchViewController: SearchedCellDelegate {
    func buttonTapped(at indexPath: IndexPath) {
        generator.impactOccurred()
        presenter.favoritesButtonTapped(indexPath: indexPath)
    }
}
