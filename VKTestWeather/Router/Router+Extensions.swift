//
//  Router+Extensions.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import Foundation

extension Router {
    static func mainModuleScreen() {
        performRoute(factory: MainModuleFactory(), context: ())
    }
}
