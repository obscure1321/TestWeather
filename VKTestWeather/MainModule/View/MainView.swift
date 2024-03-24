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
    var geoButton = UIButton()
    var textFiled = UITextField()
    var weatherView = UIView()
    var imageView = UIImageView()
    var cityName = UILabel()
    var tempLabel = UILabel()
    var descriptionLabel = UILabel()
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

// MARK: - extension for internal funcs
extension MainView {
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath) as? TableViewCell else {
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

// MARK: - extension for private flow func
private extension MainView {
    // MARK: - flow funcs
    func addViews() {
        [mainImgView, geoButton, textFiled, weatherView, tableView].forEach { addSubview($0) }
        [imageView, cityName, tempLabel, descriptionLabel].forEach { weatherView.addSubview($0) }
    }
    
    func configureProperties() {
        mainImgView.setUpImageView(radius: 0)
        mainImgView.image = UIImage(named: "background")
        
        geoButton.setUpButton(image: UIImage(systemName: "location.north.circle.fill"), 
                              radius: 22,
                              title: nil)
        
        textFiled.setUpTextField()
        textFiled.setLeftPadding(15)
        
        weatherView.setUpView(color: .clear, radius: 40)
        weatherView.addBlur(radius: 40)
    
        imageView.setUpImageView(radius: 30)
        
        cityName.setUpLabel(
            linesNumber: 0,
            alignment: .center,
            labelText: "",
            color: .label,
            fontSize: 24, weight: .bold)
        
        tempLabel.setUpLabel(
            linesNumber: 1,
            alignment: .center,
            labelText: "",
            color: .label,
            fontSize: 70, weight: .bold)
        
        descriptionLabel.setUpLabel(
            linesNumber: 0,
            alignment: .center,
            labelText: "",
            color: .label,
            fontSize: 24,
            weight: .regular)
        
        tableView.setUpTable(
            handler: self,
            cellClass: TableViewCell.self,
            cellID: "Cell")
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainImgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainImgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainImgView.topAnchor.constraint(equalTo: topAnchor),
            
            geoButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            geoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            geoButton.heightAnchor.constraint(equalToConstant: 44),
            geoButton.widthAnchor.constraint(equalToConstant: 44),
            
            textFiled.topAnchor.constraint(equalTo: geoButton.topAnchor),
            textFiled.leadingAnchor.constraint(equalTo: geoButton.trailingAnchor, constant: 10),
            textFiled.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textFiled.bottomAnchor.constraint(equalTo: geoButton.bottomAnchor),
            
            weatherView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            weatherView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weatherView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            weatherView.topAnchor.constraint(equalTo: geoButton.bottomAnchor, constant: 20),
            
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
            
            tableView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
