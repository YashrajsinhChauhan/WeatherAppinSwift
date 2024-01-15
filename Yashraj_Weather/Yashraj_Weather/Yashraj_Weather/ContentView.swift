//
//  ContentView.swift
//  Yashraj_Weather
//
//  Created by user217595 on 5/19/22.
//

import SwiftUI

struct WeatherView: View {

  @ObservedObject var viewModel: WeatherViewModel

  var body: some View {
    VStack {
        
      Text(viewModel.cityName)
        .font(.largeTitle)
        .padding()
        
     Text(viewModel.countryName)
        .font(.largeTitle)
        .padding()
        
      Text("Temperture: \(viewModel.temperature)")
        .font(.system(size: 35))
        .bold()
      
      Text("Feels Like: \(viewModel.feelsLike)")
        .font(.system(size: 27))
        .bold()
        
      Text("Wind Speed: \(viewModel.windSpeed)")
        .font(.system(size: 27))
        .bold()
        
      Text("Wind Direction: \(viewModel.windDirection)")
        .font(.system(size: 27))
        .bold()
        
      Text("Humidity: \(viewModel.humidity)")
        .font(.system(size: 27))
        .bold()
        
     Text("UV Index: \(viewModel.uvIndex)")
        .font(.system(size: 27))
        .bold()
        
        
      Text("Visibility: \(viewModel.visibility)")
        .font(.system(size: 27))
        .bold()
        
        
    }
    .alert(isPresented: $viewModel.shouldShowLocationError) {
      Alert(
        title: Text("Error"),
        message: Text("To see the weather, provide location access in Settings."),
        dismissButton: .default(Text("Open Settings")) {
          guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
          UIApplication.shared.open(settingsURL)
        }
      )
    }
    .onAppear(perform: viewModel.refresh)
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
  }
}
