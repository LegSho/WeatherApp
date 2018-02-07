//
//  JSON_DarkSkyNet.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/5/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation
import CoreLocation



public class API {
    
//    lazy var initialize only when it is called for the first time
    lazy var configuration : URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session : URLSession = URLSession.init(configuration: self.configuration)
    
    let url: URL
    init(url: URL) {
        self.url = url
    }
    
    typealias JSONHandler = (([String: Any]?) -> ())
    
    func getAPI(_ completion: @escaping JSONHandler){
        let request = URLRequest(url: self.url)
        let data = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        if let data = data {
                            do{
                                let dictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                completion(dictionary as? [String:Any])
                                
                            } catch let error as NSError {
                                print(error)
                            }
                        }
                    } else {
                        print("HTTP response code: \(response.statusCode)")
                    }
                }
            } else {
                print(error?.localizedDescription)
            }
        }
        data.resume()
    }
}









//
//func getAPI(){
//    guard let url = URL(string: baseUrl) else { return }
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//        var weatherArray: [Weather] = []
//
//        if let data = data {
//            //        let dataString = String(data: data, encoding: .utf8)
//            //        print(dataString!)
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//
//
//                    if let current = json["currently"] as? [String: Any] {
//                        for wheaterData in current {
//                            if let weather = try? Weather(json: wheaterData){
//                            weatherArray.append(weather)
//                            print(weatherArray)
//                            }
//                        }
//                    }
//                //            guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
//                //            let weather = Weather(json: json)
//                //            print(weather.temp)
//
//                }
//
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }.resume()
//}








//struct DarkSky {
//
//    public private(set) var temperature: Int32!
//    public private(set) var weather: String!
//    public private(set) var windSpeed: Int32!
//    public private(set) var windDirection: Int32!
//
//    init(json: [String: Any]) throws {
//
//        guard let currentlyTemp = json["temperature"] as? Double else { return }
//        guard let currentlyWeatherCondition = json["icon"] as? String else { return}
//        guard let currentlyWindSpeed = json["windSpeed"] as? Double else { return }
//        guard let currentlyWindDirection = json["windBearing"] as? Int32 else { return }
//
//        self.temperature = Int32(currentlyTemp)
//        self.weather = currentlyWeatherCondition
//        self.windSpeed = Int32(currentlyWindSpeed)
//        self.windDirection = currentlyWindDirection
//    }
//
//    static func getDarkSkyAPI(forLocation location: CLLocationCoordinate2D, completion: @escaping([DarkSky]) -> ()) {
//
//        let url = baseUrl + "\(location.latitude)," + "\(location.longitude)"
//        let urlRequest = URLRequest(url: URL(string: url)!)
//
//        let session = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//
//            var cityArray: [DarkSky] = []
//
//            if let data = data {
//
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                        if let currently = json["currently"] as? [[String: Any]] {
//                            for data in currently {
//                                if let weatherInfo = try? DarkSky(json: data) {
//                                    cityArray.append(weatherInfo)
//                                }
//                            }
//                        }
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                }
//                completion(cityArray)
//            }
//        }
//    }
//}

