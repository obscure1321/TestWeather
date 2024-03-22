//
//  MainView.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import UIKit

final class MainView: UIView {
    var cityName = UILabel()
    var tempLabel = UILabel()
    var descriptionLabel = UILabel()
    var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        addViews()
        configureProperties()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("there is no xib/storyboard, so init(coder:) has not been implemented")
    }
}

extension MainView {
    func addViews() {
        addSubview(cityName)
        addSubview(tempLabel)
        addSubview(descriptionLabel)
        addSubview(tableView)
    }
    
    func configureProperties() {
        cityName.setUp(
            linesNumber: 1,
            alignment: .center,
            labelText: "",
            color: .white,
            fontSize: 30, weight: .bold)
        
        tempLabel.setUp(
            linesNumber: 1,
            alignment: .center,
            labelText: "",
            color: .white,
            fontSize: 40, weight: .bold)
        
        descriptionLabel.setUp(
            linesNumber: 1,
            alignment: .center,
            labelText: "",
            color: .white,
            fontSize: 24,
            weight: .regular)
        
        tableView.setUp(
            handler: self,
            cellClass: TableViewCell.self,
            cellID: "Cell")
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            cityName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
            cityName.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 40),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 40),
            
            tableView.topAnchor.constraint(equalTo: centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func configure(with viewModel: WeatherModel) {
        self.cityName.text = viewModel.cityName
        self.tempLabel.text = "\(viewModel.temperature) °C"
        self.descriptionLabel.text = viewModel.description
    }
}

extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
