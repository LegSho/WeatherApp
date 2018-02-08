//
//  Forecast.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/6/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation


class Forecast{
    func getWeather(forLatitute latitude: Double, andLongitude longitude: Double, completion: @escaping (Weather) ->() ){
        if let urlForForecast = URL(string: "\(latitude),\(longitude)", relativeTo: urlURL!){
            
            let json = API(url: urlForForecast)
            json.getAPI({ (dictionary) in
                if let weatherDictionary = dictionary?["currently"] as? [String: Any] {
                    let currentWeather = Weather(json: weatherDictionary)
                    completion(currentWeather)
                }
            })
        }
    }
}



