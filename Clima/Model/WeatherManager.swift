//
//  WeatherNetworkManager.swift
//  Clima
//
//  Created by Ivan Behichev on 01.12.2022.
//
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager ,weather: WeatherModel)
    func didFailWeather(_ error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4703187a36d0c51488572fc4250c5e28&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlCoordinates = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlCoordinates)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWeather(error!)
                    return
                }
                if let data {
                    if let weather = self.parseJSON(data) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                        
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let city = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditonWeatherID: id, temperature: temp, cityName: city)
            return weather
        } catch {
            self.delegate?.didFailWeather(error)
            return nil
        }
        
    }

}

