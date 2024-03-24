//
//  UIExtensions.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import UIKit

extension UIButton {
    func setUpButton(image: UIImage, radius: CGFloat) {
        setBackgroundImage(image, for: .normal)
        backgroundColor = .blue
        layer.cornerRadius = radius
        translatesAutoresizingMaskIntoConstraints = false
    }
}

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

extension UILabel {
    func setUp(
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

extension UITableView {
    func setUp(handler: AnyObject, cellClass: AnyClass, cellID: String) {
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

extension UIView {
    func setUp(color: UIColor, radius: CGFloat) {
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

extension UIImageView {
    func setUp(radius: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = radius
        contentMode = .scaleAspectFill
        clipsToBounds = true
        backgroundColor = .clear
    }
}
