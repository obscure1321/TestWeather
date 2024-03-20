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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        addViews()
        propertiesConfigure()
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
    }
    
    func propertiesConfigure() {
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
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            cityName.centerYAnchor.constraint(equalTo: centerYAnchor),
            cityName.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 40),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 40)
        ])
    }
    
    func configure(with viewModel: WeatherModel) {
        self.cityName.text = viewModel.cityName
        self.tempLabel.text = "\(viewModel.temperature) °C"
        self.descriptionLabel.text = viewModel.description
    }
}
