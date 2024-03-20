//
//  OnboardingViewController.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    private var contentView = OnboardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
    }
}
