//
//  WeatherView.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 16.09.2024.
//

import UIKit
import Kingfisher

class WeatherView: UIView {
    
    private let weatherImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "questionmark")
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        view.tintColor = .tigaDarkBlue
        return view
    }()
    private let tempLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 25, weight: .bold)
        lbl.textColor = .tigaDarkBlue
        lbl.backgroundColor = .newWhite
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fetchWeatherData()
        configureWeatherView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchWeatherData() {
        WeatherService().fetchWeather { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.tempLabel.text = "tiga'da hava " + String(format: "%.1f", response.main.temp - 273.0) + "°C"
                    print("RESPONSEEEE: \(response.main.temp)")
                    self.addWeatherSembol(sembolId: response.weather[0].id)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addWeatherSembol(sembolId: Int) {
        print("Sembolll: \(sembolId)")
        switch sembolId {
        case 200...232 :
            self.weatherImageView.image = UIImage(systemName: "cloud.bolt")
        case 300...321 :
            self.weatherImageView.image = UIImage(systemName: "cloud.drizzle")
        case 500...531 :
            self.weatherImageView.image = UIImage(systemName: "cloud.rain")
        case 600...622 :
            self.weatherImageView.image = UIImage(systemName: "cloud.snow")
        case 701...781 :
            self.weatherImageView.image = UIImage(systemName: "cloud.fog")
        case 800 :
            self.weatherImageView.image = UIImage(systemName: "sun.max")
        case 801...804 :
            self.weatherImageView.image = UIImage(systemName: "cloud.bolt")
        default :
            self.weatherImageView.image = UIImage(systemName: "cloud")
        }
    }
    
    func configureWeatherView() {
        addSubview(weatherImageView)
        addSubview(tempLabel)
        weatherImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom).offset(5)
            make.leading.equalTo(weatherImageView)
            make.trailing.equalTo(weatherImageView)
            make.bottom.equalToSuperview().offset(-5)
        }
    }

}
