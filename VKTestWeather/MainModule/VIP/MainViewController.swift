//
//  MainViewController.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import UIKit

// MARK: - viewcontrollers protocol
protocol IDisplayServiceData: AnyObject {
    func displayServiceData(with viewModel: WeatherModel)
}

final class MainViewController: UIViewController {
    // MARK: - properties
    private var interactor: IBusinessLogic
    private var contentView = MainView()    
    
    
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
        view = contentView
        interactor.showData()
    }
}

// MARK: - extension for protocol submission
extension MainViewController: IDisplayServiceData {
    func displayServiceData(with viewModel: WeatherModel) {
        print("здесь будет код для отображения данных из presenter")
        DispatchQueue.main.async { [weak self] in
            self?.contentView.configure(with: viewModel)
        }
    }
}

