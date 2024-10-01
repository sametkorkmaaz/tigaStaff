//
//  WetherService.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 22.09.2024.
//

import Foundation

class WeatherService {
    private let apiURL = "https://api.openweathermap.org/data/2.5/weather?lat=39.911218&lon=32.812691&appid=4c179da5520f97fffdbaa4c522f3c2da"
    
    func fetchWeather(completion: @escaping (Result<WeatherModel, NetworkError>) -> Void) {
        NetworkManager.shared.fetchData(from: apiURL) { (result: Result<WeatherModel, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
                print(response)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
