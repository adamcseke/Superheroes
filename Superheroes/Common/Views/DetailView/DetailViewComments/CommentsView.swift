//
//  CommentsView.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 13..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

class CommentsView: UIView {
    
    private var commentsTextView: UITextView!
    private var commentsButton: UIButton!
    private var commentsButtonLabel: UILabel!
    private var countLabel: UILabel!
    private let maxLength = 500
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.userInterfaceStyle == .light {
            if commentsButton.isEnabled {
                commentsButton.backgroundColor = Colors.grayHeroName.color
            } else {
                commentsButton.backgroundColor = Colors.grayHeroName.color.withAlphaComponent(0.5)
            }
            commentsTextView.layer.borderColor = UIColor.black.cgColor
        } else {
            if commentsButton.isEnabled {
                commentsButton.backgroundColor = Colors.orange.color
            } else {
                commentsButton.backgroundColor = Colors.orange.color.withAlphaComponent(0.5)
            }
            commentsTextView.layer.borderColor = Colors.orange.color.cgColor
        }
        
    }
    
    private func setup() {
        configureButton()
        configureTextView()
        configureCountLabel()
    }
    
    private func configureTextView() {
        commentsTextView = UITextView()
        commentsTextView.delegate = self
        commentsTextView.text = L10n.CommentsView.TextView.placeholder
        commentsTextView.font = FontFamily.Gotham.book.font(size: 14)
        commentsTextView.textColor = .lightGray
        commentsTextView.keyboardType = .default
        commentsTextView.layer.cornerRadius = 11
        commentsTextView.layer.borderWidth = 2
        commentsTextView.returnKeyType = .go
        commentsTextView.isScrollEnabled = false
        commentsTextView.sizeToFit()
        
        if self.traitCollection.userInterfaceStyle == .light {
            commentsTextView.layer.borderColor = UIColor.black.cgColor
        } else {
            commentsTextView.layer.borderColor = Colors.orange.color.cgColor
        }
        
        addSubview(commentsTextView)
        
        commentsTextView.snp.makeConstraints { make in
            make.centerX.top.leading.equalToSuperview()
            make.bottom.equalTo(commentsButton.snp.top).offset(-30)
        }
    }
    
    private func configureButton() {
        commentsButton = UIButton()
        commentsButtonLabel = UILabel()
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: FontFamily.Gotham.book.font(size: 16),
            NSAttributedString.Key.foregroundColor: UIColor.systemBackground
        ]
        
        let paperplane = NSTextAttachment()
        paperplane.image = UIImage(systemName: "paperplane.fill")?.withTintColor(.systemBackground)
        let paperplaneString = NSMutableAttributedString(attachment: paperplane)
        
        var textString = NSAttributedString()
        
        textString = NSAttributedString(string: L10n.CommentsView.Button.title, attributes: attributes)
        paperplaneString.append(textString)
        commentsButton.setAttributedTitle(paperplaneString, for: .normal)
        commentsButtonLabel.textAlignment = .center
        commentsButton.layer.cornerRadius = 11
        
        if self.traitCollection.userInterfaceStyle == .light {
            commentsButton.backgroundColor = Colors.grayHeroName.color.withAlphaComponent(0.5)
        } else {
            commentsButton.backgroundColor = Colors.orange.color.withAlphaComponent(0.5)
        }
        commentsButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        commentsButton.isEnabled = false
        addSubview(commentsButton)
        commentsButton.addSubview(commentsButtonLabel)
        
        commentsButton.snp.makeConstraints { make in
            make.leading.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        commentsButtonLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func didTapButton() {
        print("tapped button")
    }
    
    private func configureCountLabel() {
        countLabel = UILabel()
        countLabel.font = FontFamily.Gotham.book.font(size: 10)
        countLabel.textColor = .label
        
        addSubview(countLabel)
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(commentsTextView.snp.bottom).offset(5)
            make.trailing.equalTo(commentsTextView.snp.trailing)
        }
    }
}

extension CommentsView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count >= 1 {
            if self.traitCollection.userInterfaceStyle == .light {
                commentsButton.backgroundColor = Colors.grayHeroName.color
            } else {
                commentsButton.backgroundColor = Colors.orange.color
            }
        } else {
            commentsButton.isEnabled = false
            if self.traitCollection.userInterfaceStyle == .light {
                commentsButton.backgroundColor = Colors.grayHeroName.color.withAlphaComponent(0.5)
            } else {
                commentsButton.backgroundColor = Colors.orange.color.withAlphaComponent(0.5)
            }
        }
        countLabel.text = "\(maxLength - textView.text.count) characters left"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= maxLength
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .label
            commentsButton.isEnabled = true
        }
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = L10n.CommentsView.TextView.placeholder
            textView.textColor = UIColor.lightGray
        }
    }
}
