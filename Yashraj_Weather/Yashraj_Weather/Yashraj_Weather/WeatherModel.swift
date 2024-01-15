//
//  WeatherModel.swift
//  Yashraj_Weather
//
//  Created by user217595 on 5/19/22.
//

import Foundation



class WeatherViewModel: ObservableObject {
  @Published var cityName: String = "City Name"
    @Published var countryName : String = "Country Name"
  @Published var temperature: String = ""
    @Published var feelsLike: String = ""
    @Published var humidity: String = ""
    @Published var windSpeed: String = ""
    @Published var windDirection: String = ""
    @Published var visibility: String = ""
    @Published var uvIndex : String = ""
    
  @Published var shouldShowLocationError: Bool = false

  public let weatherService: WeatherService

  init(weatherService: WeatherService) {
    self.weatherService = weatherService
  }

  func refresh() {
    weatherService.loadWeatherData { weather, error in
      DispatchQueue.main.async {
        if let _ = error {
          self.shouldShowLocationError = true
          return
        }

        self.shouldShowLocationError = false
        guard let weather = weather else { return }
        self.cityName = weather.city
          self.countryName = weather.country
        self.temperature = "\(weather.temperature)ºC"
          self.feelsLike = "\(weather.feelsLike)ºC"
          self.humidity = "\(weather.humidity)"
          self.windSpeed = "\(weather.windSpeed) KM/H"
          self.windDirection = "\(weather.windDirection)"
          self.visibility = "\(weather.visibility)"
          self.uvIndex = "\(weather.uvIndex)"
      }
    }
  }
}
