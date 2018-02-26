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
    lazy var configuration : URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session : URLSession = URLSession.init(configuration: self.configuration)
    typealias JSONHandler = (([String: Any]?) -> ())
    func getWeatherAndAPI(forLatitute latitude: Double, andLongitude longitude: Double, _ completion: @escaping JSONHandler){
        
        if let urlForForecast = URL(string: "\(latitude),\(longitude)", relativeTo: urlURL!){
            let request = URLRequest(url: urlForForecast)
            let data = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode == 200 {
                            if let data = data {
                               
                                    guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                                    guard let current = jsonDictionary!["currently"] as? [String: Any] else { return }
                                    print("Array from DarkSky API:",current)
                                    completion(current)
                            }
                        } else {
                            print("HTTP response code: \(response.statusCode)")
                        }
                    }
                } else {
                    print(error?.localizedDescription ?? "Error on getting json from url.")
                }
            }
            data.resume()
        }
    }
}


