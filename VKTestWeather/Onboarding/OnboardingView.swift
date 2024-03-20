//
//  OnboardingView.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import UIKit

class OnboardingView: UIView {
    // MARK: - properties
    private var imageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "onboarding")
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var mainLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 2
        element.textAlignment = .center
        element.text = NSLocalizedString("onboardingText", comment: "")
        element.textColor = .white
        element.font = UIFont.boldSystemFont(ofSize: 40)
        element.adjustsFontSizeToFitWidth = true
        element.minimumScaleFactor = 0.7
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var mainButton: UIButton = {
        let element = UIButton()
        element.setTitleColor(.white, for: .normal)
        element.setTitle(NSLocalizedString("onboardButton", comment: ""), for: .normal)
        element.titleLabel?.adjustsFontSizeToFitWidth = true
        element.titleLabel?.minimumScaleFactor = 0.5
        element.backgroundColor = .systemBlue
        element.layer.cornerRadius = 30
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("there is no xib/storyboard, so init(coder:) has not been implemented")
    }
}

// MARK: - extension for flow funcs
extension OnboardingView {
    func setUpView() {
        addSubview(imageView)
        addSubview(mainLabel)
        addSubview(mainButton)
        mainButton.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
        setConstraints()
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
    
    @objc func getStarted() {
        UserDefaults.standard.set(true, forKey: "onboarded")
        print("akdbhjz")
    }
}

