//
//  CollectionCell.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/4/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var temperatureUnit: UILabel!
    @IBOutlet weak var weatherConditionImg: UIImageView!
    @IBOutlet weak var windDirection: UIImageView!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windSpeedUnit: UILabel!
    
    func configureCell(city: City, tempUnit: String, windSpeedUnit: String){
        self.cityName.text = city.name
        
        let tempUnitUserChoice = UserDefaults.standard.value(forKey: UserDefaultsKeys.tempUnitKey) as! Int
        if tempUnitUserChoice == 0 {
            self.temperature.text = String(format:"%.0f",((city.temperature-32) * 5/9))
            temperatureUnit.text = "°C"
        } else {
            self.temperature.text = String(format:"%.0f",city.temperature)
            temperatureUnit.text = "°F"
        }
        
        weatherConditionImg.image = UIImage(named: "\((city.weatherCondition)!)")
        let direction = city.windDirection
        windDirection.image = UIImage(named: "direction0-compas")
        self.windDirection.transform = CGAffineTransform(rotationAngle: CGFloat(degreesToRad(direction)))
        
        let windUnitUserChoice = UserDefaults.standard.value(forKey: UserDefaultsKeys.windSpeedUnitKey) as! Int
        if windUnitUserChoice == 0 {
            self.windSpeed.text = String(format: "%.1f", city.windSpeed)
            self.windSpeedUnit.text = "m/s"
        } else {
            self.windSpeed.text = String(format: "%.1f", (city.windSpeed * 3.6))
            self.windSpeedUnit.text = "km/h"
        }
    }
 
    func degreesToRad(_ degrees: Int32) -> CGFloat  {
        return CGFloat(Double(degrees) * 3.1415 / 180)
    }
}
