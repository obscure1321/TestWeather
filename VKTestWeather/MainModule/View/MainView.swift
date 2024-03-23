//
//  MainView.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import UIKit

final class MainView: UIView {
    // MARK: - properties
    var mainImgView = UIImageView()
    var weatherView = UIView()
    var imageView = UIImageView()
    var cityName = UILabel()
    var tempLabel = UILabel()
    var descriptionLabel = UILabel()
    var forecastView = UIView()
    var tableView = UITableView()
    var forecastArray = [ForecastModel]()
    
    
    // MARK: - initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addViews()
        configureProperties()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("there is no xib/storyboard, so init(coder:) has not been implemented")
    }
}

extension MainView {
    // MARK: - flow funcs
    func addViews() {
        [mainImgView, weatherView, forecastView].forEach { addSubview($0) }
        forecastView.addSubview(tableView)
        [imageView, cityName, tempLabel, descriptionLabel].forEach { weatherView.addSubview($0) }
    }
    
    func configureProperties() {
        mainImgView.setUp(radius: 0)
        mainImgView.image = UIImage(named: "background")
        
        weatherView.setUp(color: .clear, radius: 40)
        weatherView.addBlur()
    
        imageView.setUp(radius: 30)
        
        forecastView.setUp(color: .clear, radius: 40)
        forecastView.addBlur()
        
        cityName.setUp(
            linesNumber: 0,
            alignment: .center,
            labelText: "",
            color: .label,
            fontSize: 24, weight: .bold)
        
        tempLabel.setUp(
            linesNumber: 1,
            alignment: .center,
            labelText: "",
            color: .label,
            fontSize: 70, weight: .bold)
        
        descriptionLabel.setUp(
            linesNumber: 0,
            alignment: .center,
            labelText: "",
            color: .label,
            fontSize: 24,
            weight: .regular)
        
        tableView.setUp(
            handler: self,
            cellClass: TableViewCell.self,
            cellID: "Cell")
        
        tableView.addBlur()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainImgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainImgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainImgView.topAnchor.constraint(equalTo: topAnchor),
            
            weatherView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            weatherView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weatherView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            weatherView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            
            imageView.leadingAnchor.constraint(equalTo: weatherView.leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: weatherView.centerXAnchor, constant: -30),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerYAnchor.constraint(equalTo: weatherView.centerYAnchor),
            
            cityName.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: 20),
            cityName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            cityName.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -20),
            cityName.bottomAnchor.constraint(equalTo: tempLabel.topAnchor, constant: -5),
            
            tempLabel.centerYAnchor.constraint(equalTo: weatherView.centerYAnchor),
            tempLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            tempLabel.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: -20),
            
            forecastView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 20),
            forecastView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            forecastView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            forecastView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: forecastView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: forecastView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: forecastView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: forecastView.bottomAnchor)
        ])
    }
    
    // MARK: - configuring with data
    func configure(with viewModel: WeatherModel) {
        self.cityName.text = viewModel.cityName
        self.tempLabel.text = "\(viewModel.temperature) °C"
        self.descriptionLabel.text = viewModel.description
        self.imageView.image = UIImage(named: viewModel.conditionName)
    }
    
    func configureForecast(with viewModels: [ForecastModel]) {
        forecastArray = viewModels
        forecastArray.removeFirst()
        tableView.reloadData()
    }
}

// MARK: - extension for UITableViewDataSource funcs
extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        if !forecastArray.isEmpty {
            let element = forecastArray[indexPath.row]
            cell.configure(temp: element.temperature,
                           date: element.dateTime,
                           desc: element.description,
                           code: element.conditionName)
        }
        return cell
    }
}

// MARK: - extension for UITableViewDelegate funcs
extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.size.height / 3.5
    }
}
