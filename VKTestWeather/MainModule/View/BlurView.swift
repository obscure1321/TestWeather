//
//  BlurView.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 23.03.2024.
//

import UIKit

final class BlurView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBlur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("there is no xib/storyboard, so init(coder:) has not been implemented")
    }
    
    func addBlur() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        addSubview(blurEffectView)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
