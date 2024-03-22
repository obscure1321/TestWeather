//
//  TableViewCell.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 22.03.2024.
//

import UIKit

final class TableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "Cell")
        backgroundColor = .systemMint
    }
    
    required init?(coder: NSCoder) {
        fatalError("There is no xib/storyboard, so init(coder:) has not been implemented")
    }
}
