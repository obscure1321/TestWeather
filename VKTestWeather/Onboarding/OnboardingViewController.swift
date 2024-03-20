//
//  OnboardingViewController.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    // MARK: - properties
    private var contentView = OnboardingView()
    
    // MARK: - life cycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
    }
}
