//
//  Functions.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/26/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Functions {

    func degreesToRad(_ degrees: Int32) -> CGFloat  {
        return CGFloat(Double(degrees) * 3.1415 / 180)
    }
    
//    func temperaturePresentation(temp: Double, tempUnitLbl: UILabel, temperatureLbl: UILabel) {
//        if let userChoice = UserDefaults.standard.value(forKey: "tempUnit") as? Int {
//            if city.name == "" {
//                tempUnitLbl.isHidden = true
//            }
//            tempUnitLbl.isHidden = false
//            let temperature = city.temperature
//            if userChoice == 0 {
//                let tempUnit = "°C"
//                tempUnitLbl.text = tempUnit
//                let result = String(format: "%.0f", (temp-32) * 5/9)
//                temperatureLbl.text = result
//            } else {
//                let tempUnit = "°F"
//                tempUnitLbl.text = tempUnit
//                let result = String(format: "%.0f", temp)
//                temperatureLbl.text = result
//            }
//        }
//    }
    
//    func windSpeedVelocityPresentation(windSpeedLbl: UILabel, windSpeedUnit: UILabel, speed: Double){
//        if let userChoise = UserDefaults.standard.value(forKey: "windSpeedUnit") as? Int {
//            if windSpeedLbl.text == "" {
//                windSpeedUnit.isHidden = true
//            }
//            windSpeedUnit.isHidden = false
//            if userChoise == 0 {
//                let windUnit = "m/s"
//                windSpeedUnit.text = windUnit
//                let result = String(format: "%.0f", speed)
//                windSpeedLbl.text = result
//            } else {
//                let windUnit = "km/h"
//                windSpeedUnit.text = windUnit
//                let result = String(format: "%.0f", (speed * 3.6))
//                windSpeedLbl.text = result
//            }
//        }
//    }
    
    func windDirectionPresentation(angle: Int32, windSpeedPicture: UIImageView){
        windSpeedPicture.image = UIImage(named: "direction0-compas")
        windSpeedPicture.transform = CGAffineTransform(rotationAngle: CGFloat(self.degreesToRad(angle)))
    }
    
    func currentDate(_ completion: (String) -> ()) {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        completion("\(day).\(month).\(year)")
    }
    
    func hideOrUnhideFirstImg(favouriteCities: [City], image: UIImageView){
        if favouriteCities.count > 0 {
            image.isHidden = true
        } else if favouriteCities.count == 0 {
            image.isHidden = false
        }
    }
    
    func arrayWithoutCurrentCity(favouriteCities: [City]) -> [City] {
        var reversedCities: [City] = []
        let currentCity = favouriteCities.last?.name
        let favouriteCitiesReversed : [City] = favouriteCities.reversed()
        for city in favouriteCitiesReversed {
            if city.name != currentCity {
                reversedCities.append(city)
            }
        }
        return reversedCities
    }
}
