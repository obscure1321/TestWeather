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
    
    init(with interactor: IBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

extension MainViewController: IDisplayServiceData {
    func displayServiceData() {
        
    }
}
