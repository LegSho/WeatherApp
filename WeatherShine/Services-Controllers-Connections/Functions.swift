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

    func getPictureForAppropriateWeather(favouriteCities: [City], weatherConditionPic: UIImageView, backgroundImg: UIImageView, cityNameLbl: UILabel, dateLbl: UILabel, temperatureLbl: UILabel, tempUnitLbl:UILabel, windSpeedLbl: UILabel, windSpeedUnit: UILabel){
        if let icon = favouriteCities.last?.weatherCondition {
            weatherConditionPic.image = UIImage(named: "\(icon)")
            if icon == "clear-day" {
                backgroundImg.image = UIImage(named: "ClearDay")
            } else if icon == "clear-night" {
                backgroundImg.image = UIImage(named: "ClearNight")
                cityNameLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                dateLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                temperatureLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                tempUnitLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedUnit.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else if icon == "partly-cloudy-day" {
                backgroundImg.image = UIImage(named: "PartlyCloudyDay")
                windSpeedUnit.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else if icon == "partly-cloudy-night" {
                backgroundImg.image = UIImage(named: "PartlyCloudyNight")
                cityNameLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                dateLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                temperatureLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                tempUnitLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedUnit.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else if icon == "cloudy" {
                backgroundImg.image = UIImage(named: "CloudyDay")
                windSpeedUnit.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else if icon == "fog" {
                backgroundImg.image = UIImage(named: "Foggy")
                cityNameLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                dateLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                temperatureLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                tempUnitLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                windSpeedUnit.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else if icon == "rain" {
                backgroundImg.image = UIImage(named: "Rainy")
                cityNameLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                dateLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                temperatureLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                tempUnitLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedUnit.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else if icon == "snow" {
                backgroundImg.image = UIImage(named: "SnowDay")
                cityNameLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                dateLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                temperatureLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                tempUnitLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedUnit.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else if icon == "sleet" {
                backgroundImg.image = UIImage(named: "SleetDay")
                cityNameLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                dateLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                temperatureLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                tempUnitLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedUnit.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else if icon == "wind" {
                backgroundImg.image = UIImage(named: "Windy")
                cityNameLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                dateLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                temperatureLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                tempUnitLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedUnit.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
}
