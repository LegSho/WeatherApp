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
        temperature.text = String(format:"%.0f",city.temperature)
        temperatureUnit.text = tempUnit
        weatherConditionImg.image = UIImage(named: "\(city.weatherCondition)")
        windDirection.image = UIImage(named: "\(city.windDirection)")
        self.windSpeed.text = String(format: "%.1f", city.windSpeed)
        self.windSpeedUnit.text = windSpeedUnit
    }
}
