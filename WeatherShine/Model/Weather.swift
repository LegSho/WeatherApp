//
//  Weather.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/6/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation


class Weather {
    let temperature: Double!
    let weatherIcon: String!
    let windSpeed: Double!
    let windDirection: Int!
    
    init(json: [String: Any]){
        temperature = json["temperature"] as? Double
        weatherIcon = json["icon"] as? String
        windSpeed = json["windSpeed"] as? Double
        windDirection = json["windBearing"] as? Int
    }
    
    /*
     "time": 1509993277,
     "summary": "Drizzle",
     "icon": "rain",
     "nearestStormDistance": 0,
     "precipIntensity": 0.0089,
     "precipIntensityError": 0.0046,
     "precipProbability": 0.9,
     "precipType": "rain",
     "temperature": 66.1,
     "apparentTemperature": 66.31,
     "dewPoint": 60.77,
     "humidity": 0.83,
     "pressure": 1010.34,
     "windSpeed": 5.59,
     "windGust": 12.03,
     "windBearing": 246,
     "cloudCover": 0.7,
     "uvIndex": 1,
     "visibility": 9.84,
     "ozone": 267.44
     
     */
}
