//
//  AlertViewController.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 18..
//  Copyright © 2022. levivig. All rights reserved.
//


import UIKit

protocol AlertViewDelegate: AnyObject {
    func buttonOneTapped()
}

class AlertViewController: UIViewController {
    
    weak var alertDelegate: AlertViewDelegate?
    
    private var transparentView: UIView!
    private var containerView: UIView!
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    private var buttonsStackView: UIStackView!
    private var actionButton: UIButton!
    private var buttonLabel: UILabel!
    private var actionButtonTwo: UIButton!
    private var buttonLabelTwo: UILabel!
    
    var alertTitle: String?
    var message: String?
    var buttonText: String?
    var alertImage: UIImage?
    var buttonTextTwo: String?
    var buttonIsHidden: Bool?
    
    init(title: String, message: String, buttonLabel: String, alertImage: UIImage, buttonLabelTwo: String, buttonHidden: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonText = buttonLabel
        self.alertImage = alertImage
        self.buttonTextTwo = buttonLabelTwo
        self.buttonIsHidden = buttonHidden
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        initGestureRecognizer()
    }
    
    private func initGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        transparentView.addGestureRecognizer(tap)
    }
    
    @objc
    private func backgroundTapped() {
        dismiss(animated: true)
    }
    
    private func setup() {
        configureViewController()
        configureTransparentView()
        configureContainerView()
        configureImageView()
        configureTitleLabel()
        configureMessageLabel()
        configureButtonsStackView()
        configureActionButton()
        configureButtonLabel()
        configureActionButtonTwo()
        configureButtonLabelTwo()
    }
    
    private func configureViewController() {
        view.backgroundColor = .black.withAlphaComponent(0.75)
    }
    
    private func configureTransparentView() {
        transparentView = UIView()
        
        view.addSubview(transparentView)
        transparentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureContainerView() {
        containerView = UIStackView()
        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .secondarySystemBackground
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    private func configureImageView() {
        imageView = UIImageView()
        imageView.image = alertImage
        imageView.tintColor = Colors.orange.color
        imageView.layer.masksToBounds = true
        containerView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.font = FontFamily.Gotham.medium.font(size: 20)
        titleLabel.text = alertTitle ?? ""
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(29)
            make.leading.equalToSuperview().offset(28)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureMessageLabel() {
        messageLabel = UILabel()
        messageLabel.numberOfLines = 4
        messageLabel.textAlignment = .center
        messageLabel.textColor = Colors.infoLabel.color
        messageLabel.text = message ?? ""
        messageLabel.font = FontFamily.Gotham.book.font(size: 13)
        containerView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(26)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureButtonsStackView() {
        buttonsStackView = UIStackView()
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.axis = .vertical
        buttonsStackView.alignment = .center
        buttonsStackView.spacing = 20
        
        containerView.addSubview(buttonsStackView)
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureActionButton() {
        actionButton = UIButton()
        actionButton.backgroundColor = Colors.orange.color
        actionButton.addTarget(self, action: #selector(buttonOneTapped), for: .touchUpInside)
        actionButton.layer.cornerRadius = 11
        actionButton.isHidden = buttonIsHidden ?? true
        buttonsStackView.addArrangedSubview(actionButton)
        
        actionButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func configureButtonLabel() {
        buttonLabel = UILabel()
        buttonLabel.text = buttonText
        buttonLabel.textColor = .systemBackground
        buttonLabel.font = FontFamily.Gotham.bold.font(size: 20)
        buttonLabel.textAlignment = .center
        buttonLabel.isHidden = buttonIsHidden ?? true
        actionButton.addSubview(buttonLabel)
        
        buttonLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureActionButtonTwo() {
        actionButtonTwo = UIButton()
        actionButtonTwo.backgroundColor = Colors.orange.color
        actionButtonTwo.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButtonTwo.layer.cornerRadius = 11
        buttonsStackView.addArrangedSubview(actionButtonTwo)
        
        actionButtonTwo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
    }
    
    private func configureButtonLabelTwo() {
        buttonLabelTwo = UILabel()
        buttonLabelTwo.text = buttonText
        buttonLabelTwo.textColor = .systemBackground
        buttonLabelTwo.font = FontFamily.Gotham.bold.font(size: 20)
        buttonLabelTwo.textAlignment = .center
        buttonLabelTwo.text = buttonTextTwo ?? ""
        actionButtonTwo.addSubview(buttonLabelTwo)
        
        buttonLabelTwo.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
  
    @objc func buttonOneTapped() {
        if let delegate = alertDelegate {
            delegate.buttonOneTapped()
            dismissVC()
        }
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}

