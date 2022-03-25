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
    
    private var fightersStackView: UIStackView!
    private var fighterOne: FighterSelectorButton!
    private var fighterTwo: FighterSelectorButton!
    private var pointsStackView: UIStackView!
    private var pointsLabel: UILabel!
    private var circleOne: CircleShapeView!
    private var circleTwo: CircleShapeView!
    private var favoritesCollectionView: UICollectionView!
    private var fightButton: UIButton!
    private var emptyAnimationView: AnimationView!
    private var emptyViewTitle: UILabel!
    private var fightAnimationView: AnimationView!
    private var fighterOneLifeView: GradientView!
    private var fighterTwoLifeView: GradientView!
    private var fighterOneLifeCounter: UILabel!
    private var fighterTwoLifeCounter: UILabel!
    private var winnerLabel: UILabel!
    private var loserLabel: UILabel!
    private var resetButton: UIButton!
    private var drawAnimation = AnimationView(name: "bomb-explode")
    
    private var fighterOneChosen: Heroes?
    private var fighterTwoChosen: Heroes?
    private var favoriteHeroes: [Heroes] = []
    
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
        presenter.getFavorites()
        if favoriteHeroes.count <= 2  {
            presenter.setTwoHeroesToFight()
        } else if fighterOneChosen != nil || fighterTwoChosen != nil && favoriteHeroes.count <= 2 {
            presenter.setTwoHeroesToFight()
        } else if fighterOneChosen != nil || fighterTwoChosen != nil {
            resetButtonTapped()
        } else {
            resetButtonTapped()
        }
        presenter.stopTimers()
        presenter.viewWillAppear(animated: true)
        fighterOne.isSelected = false
        fighterTwo.isSelected = false
        configureNotificationCenter()
        emptyAnimationView.play()
        fightButton.isEnabled = true
        fightButton.backgroundColor = Colors.orange.color
        fightAnimationView.play()
        fightAnimationView.isHidden = true
        fighterOneLifeView.isHidden = true
        fighterTwoLifeView.isHidden = true
        fighterOneLifeCounter.isHidden = true
        fighterTwoLifeCounter.isHidden = true
        winnerLabel.isHidden = true
        loserLabel.isHidden = true
        resetButton.isHidden = true
        drawAnimation.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.stopTimers()
    }
    
    private func setup() {
        configureViewController()
        configureFightersStackView()
        configureFighters()
        configurePointsStackView()
        configureCircleOne()
        configurePointsLabel()
        configureCircleTwo()
        configureFavoritesCollectionView()
        configureFightButton()
        configureEmptyTitle()
        setupEmptyAnimation()
        setupFightAnimation()
        configureFightersLifeCount()
        configureWinnerLoser()
        configureResetButton()
        presenter.getFavorites()
        presenter.setTwoHeroesToFight()
    }
    
    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func applicationDidBecomeActive(notification: NSNotification) {
        emptyAnimationView.play()
        fightAnimationView.play()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureFightersStackView() {
        fightersStackView = UIStackView()
        fightersStackView.axis = .horizontal
        fightersStackView.distribution = .equalSpacing
        
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
    }
    
    private func configureFighters() {
        fighterOne = FighterSelectorButton()
        fighterTwo = FighterSelectorButton()
        
        fighterOne.addTarget(self, action: #selector(fighterOneTapped), for: .touchUpInside)
        fighterTwo.addTarget(self, action: #selector(fighterTwoTapped), for: .touchUpInside)
        
        fightersStackView.addArrangedSubview(fighterOne)
        fightersStackView.addArrangedSubview(fighterTwo)
        
        let width =  self.view.bounds.width
        let availableWidth = width - 50
        let itemWidth = availableWidth / 2.1
        
        fighterOne.snp.makeConstraints { make in
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemWidth + 70)
        }
        
        fighterTwo.snp.makeConstraints { make in
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemWidth + 70)
        }
    }
    
    @objc private func fighterOneTapped() {
        fighterOne.isSelected.toggle()
        fighterTwo.isSelected = false
    }
    
    @objc private func fighterTwoTapped() {
        fighterTwo.isSelected.toggle()
        fighterOne.isSelected = false
    }
    
    private func configurePointsStackView() {
        pointsStackView = UIStackView()
        pointsStackView.distribution = .equalSpacing
        pointsStackView.axis = .horizontal
        
        view.addSubview(pointsStackView)
        
        pointsStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(1.05)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    private func configureCircleOne() {
        circleOne = CircleShapeView()
        circleOne.radius = 30
        circleOne.color = UIColor.blue.cgColor
        
        pointsStackView.addArrangedSubview(circleOne)
        
        circleOne.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
    }
    
    private func configurePointsLabel() {
        pointsLabel = UILabel()
        pointsLabel.text = L10n.FightViewController.Points.title
        
        pointsStackView.addArrangedSubview(pointsLabel)
    }
    
    private func configureCircleTwo() {
        circleTwo = CircleShapeView()
        circleTwo.radius = 30
        pointsStackView.addArrangedSubview(circleTwo)
        circleTwo.color = UIColor.red.cgColor
        
        circleTwo.snp.makeConstraints { make in
            make.width.equalTo(80)
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
        fightButton = UIButton()
        fightButton.setTitle(L10n.FightViewController.Button.title, for: .normal)
        fightButton.setTitleColor(.systemBackground, for: .normal)
        fightButton.backgroundColor = Colors.orange.color
        fightButton.layer.cornerRadius = 12
        fightButton.addTarget(self, action: #selector(fightButtonTapped), for: .touchUpInside)
        fightButton.isEnabled = true
        
        view.addSubview(fightButton)
        
        fightButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    @objc private func fightButtonTapped() {
        
        if fighterOneChosen?.id == fighterTwoChosen?.id {
            setupDrawAnimation()
            drawAnimation.play()
            drawAnimation.isHidden = false
            fightButton.isEnabled = false
            fightButton.backgroundColor = Colors.orange.color.withAlphaComponent(0.5)
        } else {
            self.fighterOne.isSelected = false
            self.fighterTwo.isSelected = false
            self.fightButton.isEnabled = false
            self.fightButton.backgroundColor = Colors.orange.color.withAlphaComponent(0.5)
            self.favoritesCollectionView.isHidden = true
            self.fighterOneLifeView.isHidden = false
            self.fighterTwoLifeView.isHidden = false
            self.fighterOneLifeCounter.isHidden = false
            self.fighterTwoLifeCounter.isHidden = false
            self.fightAnimationView.isHidden = false
            self.fighterOne.isEnabled = false
            self.fighterTwo.isEnabled = false
            self.fightAnimationView.play()
            guard let fighterOneChosen = self.fighterOneChosen else {
                return
            }
            
            guard let fighterTwoChosen = self.fighterTwoChosen else {
                return
            }
            
            self.fighterOneLifeCounter.text = "100%"
            self.fighterTwoLifeCounter.text = "100%"
            
            self.fighterOneLifeView.snp.remakeConstraints { make in
                make.leading.centerX.bottom.equalToSuperview()
                make.height.equalToSuperview()
            }
            
            self.fighterTwoLifeView.snp.remakeConstraints { make in
                make.leading.centerX.bottom.equalToSuperview()
                make.height.equalToSuperview()
            }
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
            make.left.centerX.equalToSuperview()
            make.centerY.equalTo(favoritesCollectionView.snp.centerY)
            make.height.width.equalTo(150)
        }
    }
    
    private func configureFightersLifeCount() {
        fighterOneLifeView = GradientView()
        fighterTwoLifeView = GradientView()
        fighterOneLifeCounter = UILabel()
        fighterTwoLifeCounter = UILabel()
        
        fighterOneLifeView.isHidden = true
        fighterTwoLifeView.isHidden = true
        fighterOneLifeCounter.isHidden = true
        fighterTwoLifeCounter.isHidden = true
        
        fighterOneLifeCounter.textColor = .label
        fighterTwoLifeCounter.textColor = .label
        fighterOneLifeCounter.layer.masksToBounds = true
        fighterTwoLifeCounter.layer.masksToBounds = true
        fighterOneLifeCounter.layer.cornerRadius = 8
        fighterTwoLifeCounter.layer.cornerRadius = 8
        fighterOneLifeCounter.backgroundColor = Colors.orange.color.withAlphaComponent(0.8)
        fighterTwoLifeCounter.backgroundColor = Colors.orange.color.withAlphaComponent(0.8)
        fighterOneLifeCounter.textAlignment = .center
        fighterTwoLifeCounter.textAlignment = .center
        fighterOneLifeCounter.font = FontFamily.Gotham.medium.font(size: 16)
        fighterTwoLifeCounter.font = FontFamily.Gotham.medium.font(size: 16)
        
        fighterOneLifeView.layer.cornerRadius = 12
        fighterTwoLifeView.layer.cornerRadius = 12
        fighterOneLifeView.layer.masksToBounds = true
        fighterTwoLifeView.layer.masksToBounds = true
        
        fighterOneLifeView.colors = [UIColor.red.withAlphaComponent(0.5), UIColor.red.withAlphaComponent(0.5), UIColor.black.withAlphaComponent(0.5)]
        fighterTwoLifeView.colors = [UIColor.red.withAlphaComponent(0.5), UIColor.red.withAlphaComponent(0.5), UIColor.black.withAlphaComponent(0.5)]
        
        fighterOne.addSubview(fighterOneLifeView)
        fighterTwo.addSubview(fighterTwoLifeView)
        fighterOne.addSubview(fighterOneLifeCounter)
        fighterTwo.addSubview(fighterTwoLifeCounter)
        
        
        fighterOneLifeView.snp.makeConstraints { make in
            make.leading.centerX.bottom.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        fighterTwoLifeView.snp.makeConstraints { make in
            make.leading.centerX.bottom.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        fighterOneLifeCounter.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-35)
            make.height.equalTo(20)
        }
        
        fighterTwoLifeCounter.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-35)
            make.height.equalTo(20)
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
    
    private func configureWinnerLoser() {
        winnerLabel = UILabel()
        loserLabel = UILabel()
        
        winnerLabel.text = L10n.FightViewController.Winner.title
        winnerLabel.font = FontFamily.Gotham.bold.font(size: 20)
        winnerLabel.isHidden = true
        winnerLabel.backgroundColor = .systemGreen.withAlphaComponent(0.8)
        winnerLabel.layer.masksToBounds = true
        winnerLabel.layer.cornerRadius = 12
        winnerLabel.textAlignment = .center
        
        loserLabel.text = L10n.FightViewController.Loser.title
        loserLabel.font = FontFamily.Gotham.bold.font(size: 20)
        loserLabel.isHidden = true
        loserLabel.backgroundColor = .systemRed.withAlphaComponent(0.8)
        loserLabel.layer.masksToBounds = true
        loserLabel.layer.cornerRadius = 12
        loserLabel.textAlignment = .center
        
        view.addSubview(winnerLabel)
        view.addSubview(loserLabel)
        
    }
    
    private func configureResetButton() {
        resetButton = UIButton()
        resetButton.setTitle(L10n.FightViewController.ResetButton.title, for: .normal)
        resetButton.setTitleColor(.systemBackground, for: .normal)
        resetButton.backgroundColor = Colors.orange.color
        resetButton.layer.cornerRadius = 12
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        resetButton.isEnabled = true
        resetButton.isHidden = true
        
        view.addSubview(resetButton)
        
        resetButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
    }
    
    @objc private func resetButtonTapped() {
        resetButton.isHidden = true
        fightButton.isHidden = false
        fightButton.isEnabled = true
        fightButton.backgroundColor = Colors.orange.color
        winnerLabel.isHidden = true
        loserLabel.isHidden = true
        fighterOneLifeView.isHidden = true
        fighterTwoLifeView.isHidden = true
        fighterOneLifeCounter.isHidden = true
        fighterTwoLifeCounter.isHidden = true
        
        fighterOne.bind(name: fighterOneChosen?.name ?? "", imageURL: fighterOneChosen?.image.url ?? "")
        fighterTwo.bind(name: fighterTwoChosen?.name ?? "", imageURL: fighterTwoChosen?.image.url ?? "")
        
        let fighterOneStat = fighterOneChosen?.powerstats.totalStat
        let fighterTwoStat = fighterTwoChosen?.powerstats.totalStat
        
        circleOne.currentProgress = fighterOneStat ?? 0.0
        circleTwo.currentProgress = fighterTwoStat ?? 0.0
        
        emptyAnimationView.isHidden = true
        emptyViewTitle.isHidden = true
        favoritesCollectionView.isHidden = false
        fighterOne.isHidden = false
        fighterTwo.isHidden = false
        pointsStackView.isHidden = false
        fightButton.isHidden = false
        fighterOne.isEnabled = true
        fighterTwo.isEnabled = true
    }
    
    private func setupDrawAnimation() {
        drawAnimation.frame = view.bounds
        drawAnimation.contentMode = .scaleAspectFit
        drawAnimation.loopMode = .playOnce
        drawAnimation.animationSpeed = 1
        drawAnimation.backgroundColor = .clear
        drawAnimation.play()
        view.addSubview(drawAnimation)
        
        drawAnimation.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
//
//    private func setHeroes() {
//        if favoriteHeroes.count >= 2 {
//            fighterOneChosen = favoriteHeroes[0]
//            fighterTwoChosen = favoriteHeroes[1]
//
//            fighterOne.bind(name: favoriteHeroes[0].name, imageURL: favoriteHeroes[0].image.url)
//            fighterTwo.bind(name: favoriteHeroes[1].name, imageURL: favoriteHeroes[1].image.url)
//
//            let fighterOneStat = favoriteHeroes[0].powerstats.totalStat
//            let fighterTwoStat = favoriteHeroes[1].powerstats.totalStat
//
//            circleOne.currentProgress = fighterOneStat
//            circleTwo.currentProgress = fighterTwoStat
//        }
//    }
        
}

// MARK: - Extensions -

extension FightViewController: FightViewInterface {
    func pushHeroOneLife() {
        fighterOneLifeCounter.text = "0%"
        winnerLabel.isHidden = false
        loserLabel.isHidden = false
        presenter.stopTimers()
        self.timerStopped()
        
        loserLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(fighterOne.snp.centerX)
            make.centerY.equalTo(favoritesCollectionView.snp.centerY)
            make.height.equalTo(35)
            make.width.equalTo(70)
            
        }
        
        winnerLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(fighterTwo.snp.centerX)
            make.centerY.equalTo(favoritesCollectionView.snp.centerY)
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
        
    }
    
    func pushHeroTwoLife() {
        fighterTwoLifeCounter.text = "0%"
        winnerLabel.isHidden = false
        loserLabel.isHidden = false
        presenter.stopTimers()
        self.timerStopped()
        
        loserLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(fighterTwo.snp.centerX)
            make.centerY.equalTo(favoritesCollectionView.snp.centerY)
            make.height.equalTo(35)
            make.width.equalTo(70)
            
        }
        
        winnerLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(fighterOne.snp.centerX)
            make.centerY.equalTo(favoritesCollectionView.snp.centerY)
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
        
    }
    
    func timerStopped() {
        fightAnimationView.isHidden = true
        fightButton.isHidden = true
        resetButton.isHidden = false
    }
    
    func setHeroOneLife(life: Double) {
        fighterOneLifeCounter.text = "\(Int(life * 100))%"
        
        // TODO - Animate life view
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
            self.fighterOneLifeView.snp.remakeConstraints { make in
                make.leading.centerX.bottom.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(life)
            }
        }
    }
    
    func setHeroTwoLife(life: Double) {
        // TODO - Animate life view
        fighterTwoLifeCounter.text = "\(Int(life * 100))%"
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseInOut, animations: {
            self.fighterTwoLifeView.snp.remakeConstraints { make in
                make.leading.centerX.bottom.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(life)
            }
        }, completion: nil)
    }
    
    func setSelectedFighter(hero: Heroes) {
        if fighterOne.isSelected {
            fighterOne.bind(name: hero.name, imageURL: hero.image.url)
            circleOne.currentProgress = hero.powerstats.totalStat
            fighterOneChosen = hero
            fighterOne.isSelected = false
        } else if fighterTwo.isSelected {
            fighterTwo.bind(name: hero.name, imageURL: hero.image.url)
            circleTwo.currentProgress = hero.powerstats.totalStat
            fighterTwoChosen = hero
            fighterTwo.isSelected = false
        } else {
            
        }
    }
    
    func pushFavoriteHeroes(heroes: [Heroes]) {
        favoriteHeroes = heroes
        print(heroes.count)
        
        if heroes.count >= 2 {

            fighterOneChosen = heroes[0]
            fighterTwoChosen = heroes[1]

            fighterOne.bind(name: heroes[0].name, imageURL: heroes[0].image.url)
            fighterTwo.bind(name: heroes[1].name, imageURL: heroes[1].image.url)

            let fighterOneStat = heroes[0].powerstats.totalStat
            let fighterTwoStat = heroes[1].powerstats.totalStat

            circleOne.currentProgress = fighterOneStat
            circleTwo.currentProgress = fighterTwoStat

            emptyAnimationView.isHidden = true
            emptyViewTitle.isHidden = true
            favoritesCollectionView.isHidden = false
            fighterOne.isHidden = false
            fighterTwo.isHidden = false
            pointsStackView.isHidden = false
            fightButton.isHidden = false
        } else {
            favoritesCollectionView.isHidden = true
            fighterOne.isHidden = true
            fighterTwo.isHidden = true
            pointsStackView.isHidden = true
            fightButton.isHidden = true
            emptyAnimationView.isHidden = false
            emptyViewTitle.isHidden = false
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
