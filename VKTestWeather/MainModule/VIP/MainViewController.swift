//
//  MainViewController.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import UIKit

// MARK: - viewcontrollers protocol
protocol IDisplayServiceData: AnyObject {
    func displayWeatherData(with viewModel: WeatherModel)
    func displayForecastData(with viewModels: [ForecastModel])
    func showAlert(with title: String)
}

final class MainViewController: UIViewController {
    // MARK: - properties
    private let interactor: IBusinessLogic
    private let contentView = MainView()    
    
    // MARK: - initialization
    init(with interactor: IBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("there is no xib/storyboard, so init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - extension for UITextFieldDelegate implementation
extension MainViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        self.interactor.showData(with: text)
        textField.text = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - extension for protocol submission
extension MainViewController: IDisplayServiceData {
    func displayWeatherData(with viewModel: WeatherModel) {
        DispatchQueue.main.async { [weak self] in
            self?.contentView.configure(with: viewModel)
        }
    }
    
    func displayForecastData(with viewModels: [ForecastModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.contentView.configureForecast(with: viewModels)
        }
    }
    
    func showAlert(with title: String) {
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

// MARK: - extension for private flow funcs
private extension MainViewController {
    func configure() {
        view = contentView
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissNumPad))
        contentView.geoButton.addTarget(self,
                                        action: #selector(getGeolocation),
                                        for: .touchUpInside)
        contentView.textFiled.delegate = self
        contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc func getGeolocation() {
        contentView.vibroGenerator.impactOccurred()
        self.interactor.reloadDataWithGeo()
    }
    
    @objc func dismissNumPad() {
        contentView.endEditing(true)
    }
}
