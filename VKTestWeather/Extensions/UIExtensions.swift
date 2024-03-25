//
//  UIExtensions.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import UIKit

// MARK: - UIButton
extension UIButton {
    func setUpButton(image: UIImage?, title: String?) {
        configuration = .filled()
        configuration?.baseForegroundColor = .white
        configuration?.baseBackgroundColor = .systemBlue
        configuration?.cornerStyle = .capsule
        translatesAutoresizingMaskIntoConstraints = false
        
        if let image = image {
            configuration?.image = image
        }
        if let title = title {
            configuration?.title = title
        }
    }
}

// MARK: - UITextField
extension UITextField {
    func setUpTextField() {
        backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        textColor = .white
        layer.cornerRadius = 16
        attributedPlaceholder = NSAttributedString(
            string: NSLocalizedString("placeholer", comment: ""),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        borderStyle = .none
        keyboardType = .default
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
}

// MARK: - UILabel
extension UILabel {
    func setUpLabel(
        linesNumber: Int,
        alignment: NSTextAlignment,
        labelText: String,
        color: UIColor,
        fontSize: CGFloat,
        weight: UIFont.Weight
    ) {
        numberOfLines = linesNumber
        textAlignment = alignment
        text = labelText
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.5
        translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - UITableView
extension UITableView {
    func setUpTable(handler: AnyObject, cellClass: AnyClass, cellID: String) {
        backgroundColor = .clear
        alwaysBounceVertical = true
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = .none
        delegate = handler as? UITableViewDelegate
        dataSource = handler as? UITableViewDataSource
        register(cellClass, forCellReuseIdentifier: cellID)
    }
}

// MARK: - UIView
extension UIView {
    func setUpView(color: UIColor, radius: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
        layer.cornerRadius = radius
    }
    
    func addBlur(radius: CGFloat) {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.layer.cornerRadius = radius
        blurEffectView.layer.masksToBounds = true
        
        insertSubview(blurEffectView, at: 0)
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: - UIImageView
extension UIImageView {
    func setUpImageView(radius: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = radius
        contentMode = .scaleAspectFill
        clipsToBounds = true
        backgroundColor = .clear
    }
}
