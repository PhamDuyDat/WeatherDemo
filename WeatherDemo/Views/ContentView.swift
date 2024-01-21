//
//  ContentView.swift
//  WeatherDemo
//
//  Created by Phạm Duy Đạt on 05/01/2024.
//

import SwiftUI

// lấy vị trí hiện tại của người dùng

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather:ResponseBody?
    var body: some View {
        VStack(){
            if let location = locationManager.location{
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentManager(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading{
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
          
        }
        .background(Color(hue: 0.649, saturation: 0.933, brightness: 0.481))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

