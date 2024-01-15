//
//  Yashraj_WeatherApp.swift
//  Yashraj_Weather
//
//  Created by user217595 on 5/19/22.
//

import SwiftUI

@main
struct Yashraj_WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
                  WeatherView(viewModel: WeatherViewModel(weatherService: weatherService))
        }
    }
}
