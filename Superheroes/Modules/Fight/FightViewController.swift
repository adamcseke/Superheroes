//
//  FightViewController.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 14..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Lottie
import UIKit

final class FightViewController: UIViewController {
    
    private var fightersStackView: FightersStackView!
    private var pointsStackView: PointsStackView!
    private var favoritesCollectionView: UICollectionView!
    private var fightButton: FightButton!
    private var emptyAnimationView: AnimationView!
    private var emptyViewTitle: UILabel!
    private var fightAnimationView: AnimationView!
    private var winnerLoserView: WinnerLoserView!
    private var resetButton: FightButton!
    private var drawAnimation = AnimationView(name: "bomb-explode")
    private var fighterOneChosen: Heroes?
    private var fighterTwoChosen: Heroes?
    
    private var fightIsOn: Bool = false
    
    private var healthOriginalHeight: CGFloat = 1
    
    // MARK: - Public properties -
    
    var presenter: FightPresenterInterface!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        configureNotificationCenter()
        emptyAnimationView.play()
        fightAnimationView.play()
        presenter.viewWillAppear(animated: true)
    }

    private func setup() {
        configureViewController()
        configureFightersStackView()
        configurePointsStackView()
        configureFavoritesCollectionView()
        configureFightButton()
        configureEmptyTitle()
        setupEmptyAnimation()
        setupFightAnimation()
        configureWinnerLoserStackView()
        configureResetButton()
        presenter.getFavorites()
    }
    
    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func updateIfEnoughFav(favoriteHeroes: [Heroes]) {
        fightIsOn ? nil : setTwoFighters(favoriteHeroes: favoriteHeroes)
        favoritesCollectionView.isHidden = fightIsOn ? true : false
        fightersStackView.fightersHidden = fightIsOn ? true : false
        fightersStackView.fightersEnabled = fightIsOn ? false : true
        pointsStackView.isHidden = fightIsOn ? true : false
        fightButton.isHidden = fightIsOn ? true : false
        resetButton.isHidden = fightIsOn ? false : true
        emptyAnimationView.isHidden = fightIsOn ? false : true
        emptyViewTitle.isHidden = fightIsOn ? false : true
        fightAnimationView.isHidden = fightIsOn ? false : true
        winnerLoserView.labelsHidden = fightIsOn ? false : true

        let randomHero = favoriteHeroes.randomElement()
        if presenter.checkFighter(fighter: fighterOneChosen?.id ?? "") == false && fighterOneChosen != nil {
            fightersStackView.setFighterOne(name: randomHero?.name ?? "", imageURL: randomHero?.image.url ?? "")
            let fighterStat = randomHero?.powerstats.totalStat
            pointsStackView.currentProgressOne = fighterStat ?? 0.0
        } else {
            fightersStackView.setFighterOne(name: fighterOneChosen?.name ?? "", imageURL: fighterOneChosen?.image.url ?? "")
            let fighterStat = fighterOneChosen?.powerstats.totalStat
            pointsStackView.currentProgressOne = fighterStat ?? 0.0
            fightersStackView.setFighterOne(name: fighterOneChosen?.name ?? "", imageURL: fighterOneChosen?.image.url ?? "")
            fightersStackView.fighterOneLife = "100%"
            fightersStackView.setFighterOneLife(life: 1.0)
            fightersStackView.lifeCountViewHidden = true
            fightButton.isEnabled = true
        }
        let random = favoriteHeroes.randomElement()
        if presenter.checkFighter(fighter: fighterTwoChosen?.id ?? "") == false && fighterTwoChosen != nil  {
            fightersStackView.setFighterTwo(name: random?.name ?? "", imageURL: random?.image.url ?? "")
            let fighterStat = random?.powerstats.totalStat
            pointsStackView.currentProgressTwo = fighterStat ?? 0.0
        } else {
            fightersStackView.setFighterTwo(name: fighterTwoChosen?.name ?? "", imageURL: fighterTwoChosen?.image.url ?? "")
            let fighterStat = fighterTwoChosen?.powerstats.totalStat
            pointsStackView.currentProgressTwo = fighterStat ?? 0.0
            fightersStackView.fighterTwoLife = "100%"
            fightersStackView.setFighterTwoLife(life: 1.0)
            fightersStackView.lifeCountViewHidden = true
            fightButton.isEnabled = true
        }
    }
    
    private func updateIfNotEnoughFav() {
        favoritesCollectionView.isHidden = true
        fightersStackView.fightersHidden = true
        pointsStackView.isHidden = true
        fightButton.isHidden = true
        fightAnimationView.isHidden = true
        emptyAnimationView.isHidden = false
        emptyViewTitle.isHidden = false
        presenter.stopTimers()
        fightIsOn = false
    }
    
    private func updateFighters(favoriteHeroes: [Heroes]) {
        let notEnoughFavorites = favoriteHeroes.count < 2
        notEnoughFavorites ? updateIfNotEnoughFav() : updateIfEnoughFav(favoriteHeroes: favoriteHeroes)
    }
    
    func setTwoFighters(favoriteHeroes: [Heroes]) {
        if favoriteHeroes.count >= 2 {
            if fighterOneChosen == nil || presenter.checkFighter(fighter: fighterOneChosen?.id ?? "") == false {
                fighterOneChosen = favoriteHeroes[0]
                fightersStackView.setFighterOne(name: favoriteHeroes[0].name, imageURL: favoriteHeroes[0].image.url)
                let fighterOneStat = favoriteHeroes[0].powerstats.totalStat
                pointsStackView.currentProgressOne = fighterOneStat
            }
            
            if fighterTwoChosen == nil ||  presenter.checkFighter(fighter: fighterTwoChosen?.id ?? "") == false {
                fighterTwoChosen = favoriteHeroes[1]
                fightersStackView.setFighterTwo(name: favoriteHeroes[1].name, imageURL: favoriteHeroes[1].image.url)
                let fighterTwoStat = favoriteHeroes[1].powerstats.totalStat
                pointsStackView.currentProgressTwo = fighterTwoStat
            }
        }
    }
    
    @objc func applicationDidBecomeActive(notification: NSNotification) {
        emptyAnimationView.play()
        fightAnimationView.play()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureFightersStackView() {
        fightersStackView = FightersStackView()
        fightersStackView.fightersHidden = true
        fightersStackView.fightersEnabled = false
        fightersStackView.lifeCountViewHidden = true
        fightersStackView.delegate = self
        view.addSubview(fightersStackView)
        
        let width =  self.view.bounds.width
        let availableWidth = width - 50
        let itemWidth = availableWidth / 2.1
        
        fightersStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(itemWidth + 70)
        }
        
        fightersStackView.setFightersConstraints(width: itemWidth, height: itemWidth + 70)
    }
    
    private func configurePointsStackView() {
        pointsStackView = PointsStackView()
        view.addSubview(pointsStackView)
        
        pointsStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(1.05)
            make.leading.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    private func configureFavoritesCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        
        let itemSize = 100
        
        flowLayout.itemSize = CGSize(width: itemSize + 20, height: itemSize)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowLayout.scrollDirection = .horizontal
        
        favoritesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        favoritesCollectionView.register(FavoriteFightersCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteFightersCollectionViewCell.reuseIdentifier)
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.backgroundColor = .systemBackground
        favoritesCollectionView.alwaysBounceHorizontal = true
        favoritesCollectionView.showsVerticalScrollIndicator = false
        favoritesCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(favoritesCollectionView)
        
        favoritesCollectionView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(1.4)
            make.centerX.leading.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    private func configureFightButton() {
        fightButton = FightButton()
        fightButton.setTitle(L10n.FightViewController.Button.title, for: .normal)
        fightButton.addTarget(self, action: #selector(fightButtonTapped), for: .touchUpInside)

        view.addSubview(fightButton)

        fightButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func fightButtonTapped() {
        
        if fighterOneChosen?.id == fighterTwoChosen?.id {
            setupDrawAnimation()
            drawAnimation.isHidden = false
            fightButton.isEnabled = false
            fightButton.backgroundColor = Colors.orange.color.withAlphaComponent(0.5)
            tabBarController?.tabBar.isHidden = true
            let timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                self.drawAnimation.isHidden = true
                self.drawAnimation.stop()
                self.fightButton.isEnabled = true
                self.fightButton.backgroundColor = Colors.orange.color
                self.tabBarController?.tabBar.isHidden = false
            }
        } else {
            fightersStackView.fighterOneSelected = false
            fightersStackView.fighterTwoSelected = false
            self.fightButton.isEnabled = false
            self.fightButton.backgroundColor = Colors.orange.color.withAlphaComponent(0.5)
            self.favoritesCollectionView.isHidden = true
            fightersStackView.lifeCountViewHidden = false
            self.fightAnimationView.isHidden = false
            fightersStackView.fightersEnabled = false
            self.fightAnimationView.play()
            fightIsOn = true
            guard let fighterOneChosen = self.fighterOneChosen else {
                return
            }
            
            guard let fighterTwoChosen = self.fighterTwoChosen else {
                return
            }
            
            fightersStackView.lifeTitle = "100%"
            fightersStackView.setFighterOneLife(life: self.healthOriginalHeight)
            fightersStackView.setFighterTwoLife(life: self.healthOriginalHeight)
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                self.presenter.fightButtonTapped(heroOne: fighterOneChosen, heroTwo: fighterTwoChosen)
            }
        }
    }
    
    private func setupFightAnimation() {
        fightAnimationView = AnimationView(name: "fight")
        fightAnimationView.isHidden = true
        fightAnimationView.frame = view.bounds
        fightAnimationView.contentMode = .scaleAspectFit
        fightAnimationView.loopMode = .loop
        fightAnimationView.animationSpeed = 1
        fightAnimationView.backgroundColor = .clear
        fightAnimationView.isHidden = true
        view.addSubview(fightAnimationView)
        
        fightAnimationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(favoritesCollectionView.snp.centerY)
            make.height.width.equalTo(150)
        }
    }
    
    private func configureEmptyTitle() {
        emptyViewTitle = UILabel()
        emptyViewTitle.textColor = .label
        emptyViewTitle.numberOfLines = 2
        emptyViewTitle.textAlignment = .center
        emptyViewTitle.font = FontFamily.Gotham.medium.font(size: 18)
        emptyViewTitle.text = L10n.FightViewController.EmptyView.title
        
        view.addSubview(emptyViewTitle)
        
        emptyViewTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview().multipliedBy(0.7)
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
            make.left.centerX.equalToSuperview()
            make.bottom.equalTo(favoritesCollectionView.snp.bottom).offset(10)
        }
    }
    
    private func configureWinnerLoserStackView() {
        winnerLoserView = WinnerLoserView()
        winnerLoserView.labelsHidden = true
        view.addSubview(winnerLoserView)
        winnerLoserView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(50)
            make.centerY.equalToSuperview().multipliedBy(1.4)
        }
    }
    
    private func configureResetButton() {
        resetButton = FightButton()
        resetButton.setTitle(L10n.FightViewController.ResetButton.title, for: .normal)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        resetButton.isHidden = true
        
        view.addSubview(resetButton)
        
        resetButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func resetButtonTapped() {
        presenter.refreshScreen()
    }
    
    private func setupDrawAnimation() {
        drawAnimation.frame = view.bounds
        drawAnimation.contentMode = .scaleAspectFit
        drawAnimation.loopMode = .playOnce
        drawAnimation.animationSpeed = 1
        drawAnimation.backgroundColor = .clear
        drawAnimation.isHidden = true
        drawAnimation.play()
        view.addSubview(drawAnimation)
        
        drawAnimation.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
    }
    
    private func resetScreen() {
        winnerLoserView.labelsHidden = false
        presenter.stopTimers()
        fightAnimationView.isHidden = true
        fightButton.isHidden = true
        resetButton.isHidden = false
        fightIsOn = false
    }
}

// MARK: - Extensions -

extension FightViewController: FightViewInterface {
    
    func pushHeroOneLife() {
        self.resetScreen()
        fightersStackView.fighterOneLife = "0%"
        winnerLoserView.remakeConstraintWinner(multipliedBy: 1.5)
        winnerLoserView.remakeConstraintLoser(multipliedBy: 0.5)
    }
    
    func pushHeroTwoLife() {
        self.resetScreen()
        fightersStackView.fighterTwoLife = "0%"
        winnerLoserView.remakeConstraintWinner(multipliedBy: 0.5)
        winnerLoserView.remakeConstraintLoser(multipliedBy: 1.5)
    }
    
    func setHeroOneLife(life: Double) {
        fightersStackView.fighterOneLife = "\(Int(life * 100))%"
        fightersStackView.setFighterOneLife(life: life)
        UIView.animate(withDuration: (fighterTwoChosen?.powerstats.hitSpeed ?? 0.0) * 0.8, delay: 0, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setHeroTwoLife(life: Double) {
        fightersStackView.fighterTwoLife = "\(Int(life * 100))%"
        fightersStackView.setFighterTwoLife(life: life)
        UIView.animate(withDuration: (fighterOneChosen?.powerstats.hitSpeed ?? 0.0) * 0.8, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func setSelectedFighter(hero: Heroes) {
        if fightersStackView.fighterOneSelected {
            fightersStackView.setFighterOne(name: hero.name, imageURL: hero.image.url)
            pointsStackView.currentProgressOne = hero.powerstats.totalStat
            fighterOneChosen = hero
        } else if fightersStackView.fighterTwoSelected {
            fightersStackView.setFighterTwo(name: hero.name, imageURL: hero.image.url)
            pointsStackView.currentProgressTwo = hero.powerstats.totalStat
            fighterTwoChosen = hero
        }
    }
    
    func pushFavoriteHeroes(heroes: [Heroes]) {
        if !fightIsOn {
            updateFighters(favoriteHeroes: heroes)
        } else if heroes.count >= 2 && fightIsOn {
            if presenter.checkFighter(fighter: fighterOneChosen?.id ?? "") == false || presenter.checkFighter(fighter: fighterTwoChosen?.id ?? "") == false {
                presenter.stopTimers()
                fightIsOn = false
                updateFighters(favoriteHeroes: heroes)
            }
        } else if heroes.count < 2 {
            updateFighters(favoriteHeroes: heroes)
        }
    }
    
    func reloadCollectionView() {
        self.favoritesCollectionView.reloadData()
    }
}

extension FightViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHero = presenter.cellForItem(at: indexPath)
        presenter.setSelectedHero(hero: selectedHero)
    }
}

extension FightViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItem(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteFightersCollectionViewCell.reuseIdentifier, for: indexPath) as? FavoriteFightersCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let hero = presenter.cellForItem(at: indexPath)
        let heroViewModel = HeroViewModel(hero: hero)
        cell.bind(hero: heroViewModel)
        return cell
    }
}

extension FightViewController: FightersStackViewDelegate {
    
    @objc func fighterOneTapped() {
        fightersStackView.fighterOneSelected.toggle()
        fightersStackView.fighterTwoSelected = false
    }
    
    @objc func fighterTwoTapped() {
        fightersStackView.fighterTwoSelected.toggle()
        fightersStackView.fighterOneSelected = false
    }
}
