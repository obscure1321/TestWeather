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
        [mainImgView, weatherView, tableView].forEach { addSubview($0) }
        [imageView, cityName, tempLabel, descriptionLabel].forEach { weatherView.addSubview($0) }
        addBlur()
    }
    
    func addBlur() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.layer.cornerRadius = 40
        blurEffectView.layer.masksToBounds = true
        
        weatherView.insertSubview(blurEffectView, at: 0)
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: weatherView.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: weatherView.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: weatherView.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor)
        ])
    }
    
    func configureProperties() {
        mainImgView.setUp(radius: 0)
        mainImgView.image = UIImage(named: "background")
        
        weatherView.setUp(color: .clear, radius: 40)
        
    
        imageView.setUp(radius: 30)
        
        cityName.setUp(
            linesNumber: 1,
            alignment: .center,
            labelText: "",
            color: .black,
            fontSize: 40, weight: .bold)
        
        tempLabel.setUp(
            linesNumber: 1,
            alignment: .center,
            labelText: "",
            color: .black,
            fontSize: 80, weight: .bold)
        
        descriptionLabel.setUp(
            linesNumber: 1,
            alignment: .center,
            labelText: "",
            color: .black,
            fontSize: 40,
            weight: .regular)
        
        tableView.setUp(
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
            
            weatherView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            weatherView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weatherView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            weatherView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            
            imageView.leadingAnchor.constraint(equalTo: weatherView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: weatherView.centerXAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerYAnchor.constraint(equalTo: weatherView.centerYAnchor),
            
            cityName.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: 20),
            cityName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            cityName.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -20),
            cityName.bottomAnchor.constraint(equalTo: tempLabel.topAnchor, constant: -10),
            
            tempLabel.centerYAnchor.constraint(equalTo: weatherView.centerYAnchor),
            tempLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            tempLabel.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = .clear
            
            let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width - 30, height: 50))
            label.text = "Next 7 days"
            label.textColor = .black
            headerView.addSubview(label)
            
            return headerView
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
