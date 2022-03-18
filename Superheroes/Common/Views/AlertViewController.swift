//
//  AlertViewController.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 18..
//  Copyright © 2022. levivig. All rights reserved.
//


import UIKit

class AlertViewController: UIViewController {
    
    private var transparentView: UIView!
    private var containerView: UIView!
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    private var actionButton: UIButton!
    private var buttonLabel: UILabel!
    
    var alertTitle: String?
    var message: String?
    var buttonText: String?
    var alertImage: UIImage?
    
    init(title: String, message: String, buttonLabel: String, alertImage: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonText = buttonLabel
        self.alertImage = alertImage
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
        configureActionButton()
        configureButtonLabel()
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
        containerView.backgroundColor = Colors.gray.color
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
        imageView.layer.masksToBounds = true
        containerView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
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
    
    private func configureActionButton() {
        actionButton = UIButton()
        actionButton.backgroundColor = Colors.orange.color
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButton.layer.cornerRadius = 11
        containerView.addSubview(actionButton)
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-64)
            make.height.equalTo(44)
        }
    }
    
    private func configureButtonLabel() {
        buttonLabel = UILabel()
        buttonLabel.text = buttonText
        buttonLabel.textColor = .white
        buttonLabel.font = FontFamily.Gotham.bold.font(size: 20)
        buttonLabel.textAlignment = .center
        actionButton.addSubview(buttonLabel)
        
        buttonLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}

