//
//  OnboardingView.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import UIKit

final class OnboardingView: UIView {
    // MARK: - properties
    let vibroGenerator = UIImpactFeedbackGenerator(style: .soft)
    private let imageView = UIImageView()
    private let mainLabel = UILabel()
    let mainButton = UIButton()
    
    // MARK: - initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        vibroGenerator.prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("there is no xib/storyboard, so init(coder:) has not been implemented")
    }
}

// MARK: - extension for flow funcs
private extension OnboardingView {
    func setUpView() {
        addSubview(imageView)
        addSubview(mainLabel)
        addSubview(mainButton)
        setConstraints()
        configureProperties()
    }
    
    func configureProperties() {
        imageView.setUpImageView(radius: 0)
        imageView.image = UIImage(named: "onboarding")
        
        mainLabel.setUpLabel(
            linesNumber: 2,
            alignment: .center,
            labelText: NSLocalizedString("onboardingText", comment: ""),
            color: .white,
            fontSize: 40,
            weight: .bold)
        
        mainButton.setUpButton(image: nil,
                               title: NSLocalizedString("onboardButton", comment: ""))
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            mainButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            mainButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            mainButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80),
            mainButton.heightAnchor.constraint(equalToConstant: 70),
            
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainLabel.bottomAnchor.constraint(equalTo: mainButton.topAnchor, constant: -40)
        ])
    }
}
