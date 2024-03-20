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
        interactor.showData()
    }
}

extension MainViewController: IDisplayServiceData {
    func displayServiceData() {
        print("здесь будет код для отображения данных из presenter")
    }
}

