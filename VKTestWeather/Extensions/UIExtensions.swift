//
//  UIExtensions.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import UIKit

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
        minimumScaleFactor = 0.7
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UITableView {
    func setUp(handler: AnyObject, cellClass: AnyClass, cellID: String) {
        backgroundColor = .lightGray
        alwaysBounceVertical = true
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = .singleLine
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

