//
//  DetailViewController.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 03..
//  Copyright (c) 2022. levivig. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var headerContainerView: UIView!
    
    private let statusBarFrame = UIApplication.shared.statusBarFrame
    private let statusBarView = UIView()
    private let generator = UIImpactFeedbackGenerator(style: .medium)
    private var gradientView: GradientView!
    private var heroImageView: UIImageView!
    private var heroNameLabel: UILabel!
    
    private var stackView: UIStackView!
    
    private var buttonsView: UIView!
    private var powerstatButton: StatButton!
    private var characteristicsButton: StatButton!
    private var commentsButton: StatButton!
    
    private var biographyView: CharacteristicsView!
    private var appearanceView: CharacteristicsView!
    private var workView: CharacteristicsView!
    private var connectionsView: CharacteristicsView!
    
    private var circlesStackView: UIStackView!
    private var circlesFirstRowView: CirclesStackView!
    private var circlesSecondRowView: CirclesStackView!
    private var heroStatsWebView: SpiderWebChartView!
    
    private var commentsView: CommentsView!
    
    private var navBarButton = UIButton(type: UIButton.ButtonType.custom)
    private var input: String?
    private var commentsStackView: UIStackView!
    private var deleteCommentsButton: UIButton!
    private var comments: [String] = []
    private var range: NSRange?
    private var text: String?
    private var cutText: String?
    
    // MARK: - Public properties -
    
    var presenter: DetailPresenterInterface!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        statusBarView.frame = statusBarFrame
        self.view.addSubview(statusBarView)
        self.hideKeyboardWhenTappedAround()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarView.backgroundColor = UIColor.clear
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = Colors.orange.color
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        presenter.getFavorites()
        presenter.viewWillAppear(animated: true)
    }
    
    fileprivate func setHeroStatistics(selectedHero: Heroes) {
        let numIntelligence = Double(selectedHero.powerstats.intelligence) ?? 0.0
        let numStrength = Double(selectedHero.powerstats.strength) ?? 0.0
        let numSpeed = Double(selectedHero.powerstats.speed) ?? 0.0
        let numDurability = Double(selectedHero.powerstats.durability) ?? 0.0
        let numPower = Double(selectedHero.powerstats.power) ?? 0.0
        let numCombat = Double(selectedHero.powerstats.combat) ?? 0.0
        
        circlesFirstRowView.currentProgressCircleOne = numIntelligence
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.circlesFirstRowView.currentProgressCircleTwo = numStrength
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.circlesFirstRowView.currentProgressCircleThree = numSpeed
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.circlesSecondRowView.currentProgressCircleOne = numDurability
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.circlesSecondRowView.currentProgressCircleTwo = numPower
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.circlesSecondRowView.currentProgressCircleThree = numCombat
        }
        self.heroStatsWebView.entries = [numIntelligence, numStrength, numSpeed, numDurability, numPower, numCombat]
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.userInterfaceStyle == .light {
            heroNameLabel.textColor = Colors.grayHeroName.color
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.grayHeroName.color]
            navBarButton.layer.backgroundColor = Colors.white.color.cgColor
        } else {
            heroNameLabel.textColor = Colors.orange.color
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.orange.color]
            navBarButton.layer.backgroundColor = Colors.saveButtonBackground.color.cgColor
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if stackView.isHidden && !circlesStackView.isHidden {
            let bottom = heroStatsWebView.frame.maxY + 20
            scrollView.contentSize = CGSize(width: view.frame.width, height: bottom)
        } else if stackView.isHidden && !commentsView.isHidden {
            let bottom = deleteCommentsButton.frame.maxY + 20
            scrollView.contentSize = CGSize(width: view.frame.width, height: bottom)
        } else {
            let bottom = stackView.frame.maxY + 20
            scrollView.contentSize = CGSize(width: view.frame.width, height: bottom)
        }
    }
    
    private func setup() {
        setNavigationBar()
        keyboardWillShowHide()
        configureScrollView()
        configureStackView()
        configureViewController()
        configureHeroImageView()
        configureHeroNameLabel()
        configureButtonsView()
        configurePowerstatsButton()
        configureCharacteristicButton()
        configureCommentsButton()
        configureCharacteristicsView()
        configureCirclesRowStackView()
        configureCirclesRow()
        configureHeroStatsWebView()
        configureCommentsView()
        configureCommentsStackView()
        configureDeleteCommentsButton()
    }
    
    private func keyboardWillShowHide() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        
        self.view.addSubview(navBar)
        
        navBarButton.setImage(UIImage(systemName: "star"), for: .normal)
        navBarButton.addTarget(self, action:#selector(didTapNavBarButton), for: .touchUpInside)
        navBarButton.layer.cornerRadius = 18.5
        navBarButton.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
        let barButton = UIBarButtonItem(customView: navBarButton)
        self.navigationItem.rightBarButtonItems = [barButton]
        
        if self.traitCollection.userInterfaceStyle == .light {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.grayHeroName.color]
            navBarButton.layer.backgroundColor = Colors.white.color.cgColor
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.orange.color]
            navBarButton.layer.backgroundColor = Colors.saveButtonBackground.color.cgColor
        }
        
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc private func didTapNavBarButton() {
        generator.impactOccurred()
        presenter.favoritesButtonTapped()
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .systemBackground
        scrollView.contentInset = UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: UIApplication.safeAreaInsets.bottom,
                                               right: 0)
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureHeroImageView() {
        heroImageView = UIImageView()
        headerContainerView = UIView()
        gradientView = GradientView()
        
        scrollView.addSubview(headerContainerView)
        headerContainerView.addSubview(heroImageView)
        heroImageView.addSubview(gradientView)
        
        gradientView.colors = [.clear, .clear, .systemBackground.withAlphaComponent(1)]
        gradientView.snp.makeConstraints { make in
            make.leading.bottom.centerX.equalToSuperview()
            make.top.equalTo(headerContainerView.snp.top)
        }
        
        headerContainerView.snp.makeConstraints { make in
            make.leading.trailing.centerX.equalToSuperview()
            make.height.equalTo(view.frame.height)
            make.bottom.equalTo(stackView.snp.top)
        }
        
        heroImageView.clipsToBounds = true
        heroImageView.contentMode = .scaleAspectFill
        
        heroImageView.snp.makeConstraints { make in
            make.leading.centerX.bottom.equalToSuperview()
            make.top.equalTo(view.snp.top).priority(900)
        }
    }
    
    private func configureHeroNameLabel() {
        heroNameLabel = UILabel()
        if UIDevice.Devices.iPhoneSE1stGen {
            heroNameLabel.font = UIFont(font: FontFamily.Gotham.bold, size: 27)
        } else {
            heroNameLabel.font = UIFont(font: FontFamily.Gotham.bold, size: 37)
        }
        if self.traitCollection.userInterfaceStyle == .light {
            heroNameLabel.textColor = Colors.grayHeroName.color
        } else {
            heroNameLabel.textColor = Colors.orange.color
        }
        scrollView.addSubview(heroNameLabel)
        
        heroNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(headerContainerView.snp.bottom).offset(-65).priority(.required)
        }
    }
    
    private func configureButtonsView() {
        buttonsView = UIView()
        
        scrollView.addSubview(buttonsView)
        
        buttonsView.snp.makeConstraints { make in
            make.bottom.equalTo(headerContainerView.snp.bottom).offset(-25)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(27)
        }
    }
    
    private func configurePowerstatsButton() {
        powerstatButton = StatButton()
        powerstatButton.addTarget(self, action: #selector(powerstatsButtonTapped), for: .touchUpInside)
        powerstatButton.bind(buttonLabelText: L10n.DetailViewController.Powerstats.Button.title)
        powerstatButton.isSelected = true
        
        buttonsView.addSubview(powerstatButton)
        
        powerstatButton.snp.makeConstraints { make in
            if UIDevice.Devices.iPhoneSE1stGen {
                make.width.equalTo(85)
            }
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(96)
            make.height.equalTo(27)
        }
    }
    
    private func configureCharacteristicButton() {
        characteristicsButton = StatButton()
        characteristicsButton.addTarget(self, action: #selector(characteristicsButtonTapped), for: .touchUpInside)
        characteristicsButton.bind(buttonLabelText: L10n.DetailViewController.Characteristics.Button.title)
        characteristicsButton.isSelected = false
        
        buttonsView.addSubview(characteristicsButton)
        
        characteristicsButton.snp.makeConstraints { make in
            if UIDevice.Devices.iPhoneSE1stGen {
                make.width.equalTo(115)
                make.leading.equalTo(powerstatButton.snp.trailing).offset(5)
            }
            make.centerY.equalToSuperview()
            make.leading.equalTo(powerstatButton.snp.trailing).offset(10)
            make.width.equalTo(118)
            make.height.equalTo(27)
        }
    }
    
    private func configureCommentsButton() {
        commentsButton = StatButton()
        commentsButton.addTarget(self, action: #selector(commentsButtonTapped), for: .touchUpInside)
        commentsButton.bind(buttonLabelText: L10n.DetailViewController.Comments.Button.title)
        commentsButton.isSelected = false
        
        buttonsView.addSubview(commentsButton)
        
        commentsButton.snp.makeConstraints { make in
            if UIDevice.Devices.iPhoneSE1stGen {
                make.width.equalTo(85)
                make.leading.equalTo(characteristicsButton.snp.trailing).offset(5)
            }
            make.leading.equalTo(characteristicsButton.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(96)
            make.height.equalTo(27)
        }
    }
    
    @objc private func powerstatsButtonTapped() {
        presenter.powerstatsButtonTapped()
    }
    
    @objc private func characteristicsButtonTapped() {
        presenter.characteristicsButtonTapped()
    }
    
    @objc private func commentsButtonTapped() {
        presenter.commentsButtonTapped()
    }
    
    private func configureStackView() {
        stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 27
        stackView.distribution = .equalSpacing
        stackView.isHidden = true
        
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.frame.height * 0.75)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureCharacteristicsView() {
        biographyView = CharacteristicsView()
        appearanceView = CharacteristicsView()
        workView = CharacteristicsView()
        connectionsView = CharacteristicsView()
        
        biographyView.title = L10n.DetailViewController.BiographyView.SectionTitle.biography
        appearanceView.title = L10n.DetailViewController.BiographyView.SectionTitle.appearance
        workView.title = L10n.DetailViewController.BiographyView.SectionTitle.work
        connectionsView.title = L10n.DetailViewController.BiographyView.SectionTitle.connections
        
        stackView.addArrangedSubview(biographyView)
        stackView.addArrangedSubview(appearanceView)
        stackView.addArrangedSubview(workView)
        stackView.addArrangedSubview(connectionsView)
        
        biographyView.snp.makeConstraints { make in
            make.leading.centerX.equalToSuperview()
        }
        appearanceView.snp.makeConstraints { make in
            make.leading.centerX.equalToSuperview()
        }
        workView.snp.makeConstraints { make in
            make.leading.centerX.equalToSuperview()
        }
        connectionsView.snp.makeConstraints { make in
            make.leading.centerX.equalToSuperview()
        }
    }
    
    
    fileprivate func makeInfo(_ mirrorObject: Mirror, characteristicsView: CharacteristicsView, characteristicViewName: String ) {
        for (_, attr) in mirrorObject.children.enumerated() {
            
            if let propertyName = attr.label as String? {
                if let arrayString = attr.value as? [String] {
                    characteristicsView.addItem(title: "detailViewController.\(characteristicViewName).\(propertyName)".localized,
                                          info:  "\(arrayString.joined(separator: ", "))")
                } else {
                    characteristicsView.addItem(title: "detailViewController.\(characteristicViewName).\(propertyName)".localized,
                                          info: "\(attr.value)")
                }
            }
        }
    }
    
    private func addInfos(hero: Heroes) {
        let bio = hero.biography
        let heroAppearance = hero.appearance
        let heroWork = hero.work
        let heroConnections = hero.connections
        
        let biography = Mirror(reflecting: bio)
        let appearance = Mirror(reflecting: heroAppearance)
        let work = Mirror(reflecting: heroWork)
        let connections = Mirror(reflecting: heroConnections)
        
        makeInfo(biography, characteristicsView: biographyView, characteristicViewName: "biographyView")
        makeInfo(appearance, characteristicsView: appearanceView, characteristicViewName: "appearanceView")
        makeInfo(work, characteristicsView: workView, characteristicViewName: "workView")
        makeInfo(connections, characteristicsView: connectionsView, characteristicViewName: "connectionsView")
    }
    
    private func configureCirclesRowStackView() {
        circlesStackView = UIStackView()
        circlesStackView.alignment = .leading
        circlesStackView.axis = .vertical
        circlesStackView.spacing = 15
        circlesStackView.distribution = .equalSpacing
        circlesStackView.isHidden = false
        
        scrollView.addSubview(circlesStackView)
        
        circlesStackView.snp.makeConstraints { make in
            make.top.equalTo(buttonsView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureCirclesRow() {
        circlesFirstRowView = CirclesStackView()
        circlesSecondRowView = CirclesStackView()
        
        circlesFirstRowView.colorCircleOne = Colors.progressCircleRed.color.cgColor
        circlesFirstRowView.colorCircleTwo = Colors.progressCirclePink.color.cgColor
        circlesFirstRowView.colorCircleThree = Colors.progressCircleGreen.color.cgColor
        circlesSecondRowView.colorCircleOne = Colors.progressCircleBlue.color.cgColor
        circlesSecondRowView.colorCircleTwo = Colors.progressCircleBrown.color.cgColor
        circlesSecondRowView.colorCircleThree = Colors.progressCircleOrange.color.cgColor
        
        circlesFirstRowView.titleCircleOne = L10n.DetailViewController.Powerstats.intelligence
        circlesFirstRowView.titleCircleTwo = L10n.DetailViewController.Powerstats.strength
        circlesFirstRowView.titleCircleThree = L10n.DetailViewController.Powerstats.speed
        circlesSecondRowView.titleCircleOne = L10n.DetailViewController.Powerstats.duranility
        circlesSecondRowView.titleCircleTwo = L10n.DetailViewController.Powerstats.power
        circlesSecondRowView.titleCircleThree = L10n.DetailViewController.Powerstats.combat
        
        circlesStackView.addArrangedSubview(circlesFirstRowView)
        circlesStackView.addArrangedSubview(circlesSecondRowView)
        
        circlesFirstRowView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        circlesSecondRowView.snp.makeConstraints { make in
            make.bottom.centerX.equalToSuperview()
        }
    }
    
    private func configureHeroStatsWebView() {
        heroStatsWebView = SpiderWebChartView()
        heroStatsWebView.isHidden = false
        scrollView.addSubview(heroStatsWebView)
        
        heroStatsWebView.snp.makeConstraints { make in
            make.top.equalTo(circlesStackView.snp.bottom).offset(20)
            make.leading.equalTo(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(scrollView.snp.width)
        }
    }
    
    private func configureCommentsView() {
        commentsView = CommentsView()
        commentsView.bind(delegate: self)
        commentsView.isHidden = true
        scrollView.addSubview(commentsView)
        commentsView.snp.makeConstraints { make in
            make.top.equalTo(buttonsView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    private func configureCommentsStackView() {
        commentsStackView = UIStackView()
        commentsStackView.axis = .vertical
        commentsStackView.spacing = 8
        commentsStackView.alignment = .leading
        commentsStackView.distribution = .equalSpacing
        commentsStackView.isHidden = true
        
        scrollView.addSubview(commentsStackView)
        
        commentsStackView.snp.makeConstraints { make in
            make.top.equalTo(commentsView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    func addComments(items: [String]) {
        for item in items {
            addComment(item: item)
        }
    }
    
    func addComment(item: String) {
        let commentsView = Comments()
        commentsView.text = item
        commentsStackView.addArrangedSubview(commentsView)
    }
    
    private func configureDeleteCommentsButton() {
        deleteCommentsButton = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .black, scale: .large)
        let image = UIImage(systemName: "trash.circle.fill", withConfiguration: imageConfig)
        deleteCommentsButton.setImage(image, for: .normal)
        deleteCommentsButton.tintColor = Colors.orange.color
        deleteCommentsButton.isHidden = true
        deleteCommentsButton.addTarget(self, action: #selector(binButtonTapped), for: .touchUpInside)
        
        scrollView.addSubview(deleteCommentsButton)
        
        deleteCommentsButton.snp.makeConstraints { make in
            make.top.equalTo(commentsStackView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    @objc private func binButtonTapped() {
        deleteCommentsButton.isHidden = true
        commentsStackView.removeAllArrangedSubviews()
        commentsStackView.isHidden = true
        presenter.binButtonTapped()
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height * 0.6
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

// MARK: - Extensions -

extension DetailViewController: DetailViewInterface {
   
    func pushComments(comments: [String]) {
        self.comments = comments
        self.addComments(items: comments)
    }
    
    func setNavBarImage(image: String) {
        navBarButton.setImage(UIImage(systemName: image), for: .normal)
    }
    
    func setPowerstatsButton(selected: Bool) {
        stackView.isHidden = true
        powerstatButton.isSelected = true
        characteristicsButton.isSelected = false
        commentsButton.isSelected = false
        circlesStackView.isHidden = false
        heroStatsWebView.isHidden = false
        commentsView.isHidden = true
        commentsStackView.isHidden = true
        deleteCommentsButton.isHidden = true
    }
    
    func setCharacteristicsButton(selected: Bool) {
        stackView.isHidden = false
        characteristicsButton.isSelected = true
        powerstatButton.isSelected = false
        commentsButton.isSelected = false
        circlesStackView.isHidden = true
        heroStatsWebView.isHidden = true
        commentsView.isHidden = true
        commentsStackView.isHidden = true
        deleteCommentsButton.isHidden = true
    }
    func setCommentsButton(selected: Bool) {
        stackView.isHidden = true
        commentsButton.isSelected = true
        powerstatButton.isSelected = false
        characteristicsButton.isSelected = false
        circlesStackView.isHidden = true
        heroStatsWebView.isHidden = true
        commentsView.isHidden = false
        commentsStackView.isHidden = false
        if comments.isEmpty {
            deleteCommentsButton.isHidden = true
        } else {
            deleteCommentsButton.isHidden = false
        }
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    private func downloadHeroImage(imageURL: String) {
        heroImageView.sd_setImage(with: URL(string: imageURL),
                                  placeholderImage: Images.superhero.image)
    }
    
    private func setHeroName(name: String) {
        heroNameLabel.text = name
    }
    
    func pushHero(_ hero: Heroes) {
        addInfos(hero: hero)
        setHeroStatistics(selectedHero: hero)
        downloadHeroImage(imageURL: hero.image.url)
        setHeroName(name: hero.name)
    }
    
    func pushCutText(text: String) {
        if text.count == 500 {
            commentsView.commentText = text
            commentsView.countText = "0 character left"
            commentsView.commentButtonEnabled = true
            commentsView.buttonColor = self.traitCollection.userInterfaceStyle == .light ? Colors.grayHeroName.color : Colors.orange.color
            self.input = commentsView.commentText
        } else {
            commentsView.commentText = text
            self.input = commentsView.commentText
        }
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let maxHeight = scrollView.frame.height * 0.55

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
            guard let safeSelf = self else { return }
            
            let hideAnimation = offsetY > maxHeight
            if safeSelf.traitCollection.userInterfaceStyle == .light {
                safeSelf.navBarButton.layer.backgroundColor = Colors.white.color.cgColor
            } else {
                safeSelf.navBarButton.layer.backgroundColor = Colors.saveButtonBackground.color.cgColor
            }
            safeSelf.statusBarView.backgroundColor = hideAnimation ? UIColor.systemBackground : UIColor.clear
            safeSelf.heroNameLabel.alpha = hideAnimation ? 0.0 : 1.0
            safeSelf.navigationItem.title = hideAnimation ? safeSelf.heroNameLabel.text : ""
            safeSelf.navigationController?.navigationBar.backgroundColor = hideAnimation ? .systemBackground : .clear
        }, completion: nil)
    }
}

extension DetailViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension DetailViewController: CommentViewDelegate {
    
    func textAndRange(shouldChangeTextIn range: NSRange, replacementText text: String) {
        self.range = range
        self.text = text
    }
    
    func textviewDidChange(text: String) {
        presenter.checkIfLongText(text: text, delegate: self)
        let cleanInput = text.trimmingCharacters(in: .whitespacesAndNewlines)
        self.input = cleanInput
    }
    
    func buttonTapped() {
        let currentDateTime = Date()
        presenter.commentPushButtonTapped(comment: self.input ?? "", date: currentDateTime)
        comments.append(self.input ?? "")
        self.addComment(item: comments.last ?? "")
        deleteCommentsButton.isHidden = false
        self.commentsStackView.isHidden = false
    }
}

extension DetailViewController: AlertViewDelegate {
    func buttonTwoTapped() {
        presenter.buttonCancelTapped(range: self.range ?? NSRange(), text: self.input ?? "", clipBoardText: self.text ?? "")
    }
    
    func buttonOneTapped() {
        presenter.buttonCutTapped(range: self.range ?? NSRange(), text: self.text ?? "")
    }
}
