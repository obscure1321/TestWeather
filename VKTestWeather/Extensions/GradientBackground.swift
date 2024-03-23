//
//  GradientBackground.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 23.03.2024.
//

import UIKit

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

public enum GradientOrientation {
  case topRight
  case topLeft
  case horizontal
  case vertical

var startPoint: CGPoint {
    return points.startPoint
}

var endPoint: CGPoint {
    return points.endPoint
}

var points: GradientPoints {
    switch self {
    case .topRight:
        return (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0))
    case .topLeft:
        return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 1, y: 1))
    case .horizontal:
        return (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
    case .vertical:
        return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 0.0, y: 1.0))
    }
  }
}

extension UIView {
func applyGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation) {
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.frame = self.bounds
    gradient.colors = colours.map { $0.cgColor }
    gradient.startPoint = orientation.startPoint
    gradient.endPoint = orientation.endPoint
    self.layer.insertSublayer(gradient, at: 0)
  }
}
