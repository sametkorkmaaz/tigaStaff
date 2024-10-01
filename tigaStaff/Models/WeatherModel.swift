//
//  WeatherModel.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 22.09.2024.
//

import Foundation

struct WeatherModel : Codable{
    
    let name : String
    let main: MainData // main i parçalamamız gerekiyor
    let weather : [Weather] // formatta weather [] halinde

}
struct MainData: Codable {
    let temp: Double  // JSON formatında main içindeki temp derece verisi
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}
struct Weather : Codable {
    let id : Int // Belirli sayı aralıklarına göre hava durumu açıklaması veriliyor
    let description : String // hava dururmu açıklaması
    
}
