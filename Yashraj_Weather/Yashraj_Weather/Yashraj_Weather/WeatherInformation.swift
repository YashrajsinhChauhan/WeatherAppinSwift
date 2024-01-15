//
//  WeatherInformation.swift
//  Yashraj_Weather
//
//  Created by user217595 on 5/19/22.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject {

  private let locationManager = CLLocationManager()
  private let API_KEY = "59f9be6534a1454f86410310222005"
  private var completionHandler: ((Weather?, LocationAuthError?) -> Void)?
  private var dataTask: URLSessionDataTask?
    
    public override init() {
    super.init()
    locationManager.delegate = self
  }

  public func loadWeatherData(
    _ completionHandler: @escaping((Weather?, LocationAuthError?) -> Void)
  ) {
    self.completionHandler = completionHandler
    loadDataOrRequestLocationAuth()
  }

  private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
    guard let urlString =
            "https://api.weatherapi.com/v1/current.json?key=\(API_KEY)&q=\(coordinates.latitude),\(coordinates.longitude)"
        .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
    guard let url = URL(string: urlString) else { return }

    // Cancel previous task
    dataTask?.cancel()

    dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
      guard error == nil, let data = data else { return }
  
      if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
        self.completionHandler?(Weather(response: response), nil)
      }
    }
    dataTask?.resume()
  }
  
  private func loadDataOrRequestLocationAuth() {
    switch locationManager.authorizationStatus {
    case .authorizedAlways, .authorizedWhenInUse:
      locationManager.startUpdatingLocation()
    case .denied, .restricted:
      completionHandler?(nil, LocationAuthError())
    default:
      locationManager.requestWhenInUseAuthorization()
    }
  }
}

extension WeatherService: CLLocationManagerDelegate {
  public func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
  ) {
    guard let location = locations.first else { return }
    makeDataRequest(forCoordinates: location.coordinate)
  }

  public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    loadDataOrRequestLocationAuth()
  }
  public func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print("")
  }
}

struct APIResponse: Decodable {
    
    let current: APICurrent
    let location: APILocation
    
}

struct APICurrent: Decodable {
    
    let temp_c: Double
    let feelslike_c: Double
    let wind_kph: Double
    let wind_dir: String
    let humidity: Double
    let vis_km: Double
    let uv: Double

}

struct APILocation: Decodable {
    
    let name: String
    let country: String

}


public struct LocationAuthError: Error {}
