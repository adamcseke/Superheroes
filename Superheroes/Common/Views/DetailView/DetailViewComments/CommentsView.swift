//
//  CommentsView.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 13..
//  Copyright © 2022. levivig. All rights reserved.
//

import UIKit

protocol CommentViewDelegate: AnyObject {
    func buttonTapped()
    func textviewDidChange(text: String)
    func textAndRange(shouldChangeTextIn range: NSRange, replacementText text: String)
}

class CommentsView: UIView {
    
    weak var delegate: CommentViewDelegate?
    
    private var commentsTextView: UITextView!
    private var commentsButton: UIButton!
    private var commentsButtonLabel: UILabel!
    private var countLabel: UILabel!
    private let maxLength = 501
    
    var commentText: String = "" {
        didSet {
            commentsTextView.text = commentText
            print(commentText)
        }
    }
    
    var countText: String = "" {
        didSet {
            countLabel.text = countText
        }
    }
    
    var commentButtonEnabled: Bool = false {
        didSet {
            commentsButton.isEnabled = commentButtonEnabled
        }
    }
    
    var buttonColor: UIColor? {
        didSet {
            commentsButton.backgroundColor = buttonColor
        }
    }
    
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
        commentsTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        
        if self.traitCollection.userInterfaceStyle == .light {
            commentsTextView.layer.borderColor = UIColor.black.cgColor
        } else {
            commentsTextView.layer.borderColor = Colors.orange.color.cgColor
        }
        
        addSubview(commentsTextView)
        
        commentsTextView.snp.makeConstraints { make in
            make.centerX.top.leading.equalToSuperview()
            make.bottom.equalTo(commentsButton.snp.top).offset(-30)
            make.height.greaterThanOrEqualTo(100)
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
        if let delegate = delegate {
            delegate.buttonTapped()
        }
        print("tapped button")
        commentsTextView.text = ""
        let cleanInput = commentsTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanInput.count >= 1 {
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
        commentsTextView.text = L10n.CommentsView.TextView.placeholder
        commentsTextView.textColor = UIColor.lightGray
        commentsTextView.snp.updateConstraints { make in
            make.height.greaterThanOrEqualTo(100)
        }
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
    
    func bind(delegate: CommentViewDelegate?) {
        self.delegate = delegate
    }
}

extension CommentsView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textView.center.x - 10, y: textView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textView.center.x + 10, y: textView.center.y))
        
        print(textView.text.count)
        
        if textView.text.count > 500 {
            textView.layer.add(animation, forKey: "position")
            self.commentsTextView.layer.borderColor = UIColor.systemRed.cgColor
            textView.text.removeLast()
            self.countLabel.text = "\(maxLength - textView.text.count) characters left"
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                self.commentsTextView.layer.borderColor = Colors.orange.color.cgColor
            }
        }
        
        delegate?.textviewDidChange(text: textView.text ?? "")
        
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        func returnStringWidth(font: UIFont, text: String) -> CGSize {
            let fontAttributes = [NSAttributedString.Key.font: font]
            let size = (text as NSString).size(withAttributes: fontAttributes)
            
            return size
        }
        
        if size.height == 100 {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                textView.snp.updateConstraints { make in
                    make.height.greaterThanOrEqualTo(estimatedSize.height)
                }
            }, completion: nil)
            
        }
        
        let cleanInput = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanInput.count >= 1 {
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
        countLabel.text = "\((maxLength - 1) - textView.text.count) characters left"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        delegate?.textviewDidChange(text: newText)
        delegate?.textAndRange(shouldChangeTextIn: range, replacementText: text)
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
            textView.snp.updateConstraints { make in
                make.height.greaterThanOrEqualTo(100)
            }
        }
    }
}
