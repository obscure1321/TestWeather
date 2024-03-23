//
//  TableViewCell.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 22.03.2024.
//

import UIKit

final class TableViewCell: UITableViewCell {
    // MARK: - properties
    private var mainView = UIView()
    private var tempLabel = UILabel()
    private var descLabel = UILabel()
    private var dateLabel = UILabel()
    private var imgView = UIImageView()
    
    // MARK: - initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "Cell")
        backgroundColor = .clear
        addViews()
        setConstraints()
        configureProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("There is no xib/storyboard, so init(coder:) has not been implemented")
    }
}

extension TableViewCell {
    // MARK: - flow funcs
    func addViews() {
        [mainView, imgView, tempLabel, descLabel, dateLabel].forEach { addSubview($0) }
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            imgView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            imgView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            imgView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor),
            
            tempLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10),
            tempLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -5),
            tempLabel.topAnchor.constraint(equalTo: imgView.topAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -40),
            
            dateLabel.topAnchor.constraint(equalTo: tempLabel.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: tempLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            
            descLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 10),
            descLabel.bottomAnchor.constraint(equalTo: imgView.bottomAnchor),
            descLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10),
            descLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10)
        ])
    }
    
    func configureProperties() {
        mainView.setUp(color: .lightGray, radius: 20)
        tempLabel.setUp(linesNumber: 1,
                        alignment: .left,
                        labelText: "",
                        color: .black,
                        fontSize: 24,
                        weight: .bold)
        descLabel.setUp(linesNumber: 1,
                        alignment: .left,
                        labelText: "sfg",
                        color: .black,
                        fontSize: 20,
                        weight: .medium)
        dateLabel.setUp(linesNumber: 1,
                        alignment: .right,
                        labelText: "",
                        color: .black,
                        fontSize: 20,
                        weight: .medium)
        imgView.setUp(radius: 15)
    }
    
    // MARK: - configuring cell and formating date
    func configure(temp: Int, date: String, desc: String, code: String ) {
        self.tempLabel.text = "\(temp) °C"
        self.dateLabel.text = formatDate(date) ?? "???"
        self.descLabel.text = desc
        self.imgView.image = UIImage(named: code)
    }
    
    func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        dateFormatter.dateFormat = "dd MMMM"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
