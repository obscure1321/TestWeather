//
//  Factory.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import Foundation

public protocol Factory: AnyObject {
    associatedtype Context
    associatedtype ViewController
    func build(from context: Context) -> ViewController
}
