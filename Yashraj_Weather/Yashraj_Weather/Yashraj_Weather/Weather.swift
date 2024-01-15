//
//  Weather.swift
//  Yashraj_Weather
//
//  Created by user217595 on 5/19/22.
//

import Foundation

public struct Weather {
  let city: String
    let country : String
  let temperature: String
    let feelsLike: String
    let humidity : String
    let windSpeed : String
    let windDirection : String
    let visibility : String
    let uvIndex : String
  

  init(response: APIResponse) {
      
      visibility = "\(Int(response.current.vis_km))"
      city = response.location.name
      country = response.location.country
    temperature = "\(Int(response.current.temp_c))"
      feelsLike = "\(Int(response.current.feelslike_c))"
      humidity = "\(Int(response.current.humidity))"
      windSpeed = "\(Int(response.current.wind_kph))"
      windDirection = response.current.wind_dir
      uvIndex = "\(Int(response.current.uv))"
    
  }
}
