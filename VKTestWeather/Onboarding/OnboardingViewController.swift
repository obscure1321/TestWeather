//
//  OnboardingViewController.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    // MARK: - properties
    private let contentView = OnboardingView()
    
    // MARK: - life cycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        contentView.mainButton.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
    }
    
    @objc private func getStarted() {
        contentView.vibroGenerator.impactOccurred()
        UserDefaults.standard.set(true, forKey: "onboarded")
        self.dismiss(animated: true)
        Router.mainModuleScreen()
    }
}
