//
//  MainViewController.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import UIKit

protocol IDisplayServiceData: AnyObject {
    func displayServiceData()
}

final class MainViewController: UIViewController {
    private var interactor: IBusinessLogic
    private var contentView = MainView()
    private var weatherManager = WeatherManager()
    
    init(with interactor: IBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("there is no xib/storyboard, so init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        weatherManager.delegate = self
        getData()
    }
}

extension MainViewController: IDisplayServiceData {
    func displayServiceData() {
        
    }
    
    func getData() {
        weatherManager.fetchWeather(cityName: "shymkent")
    }
}

extension MainViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
    }
    
    func didFailWithError(error: WeatherError) {
        print("\(error.code): \(error.localizedDescription)")
    }
}
