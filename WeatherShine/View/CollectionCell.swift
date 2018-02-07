//
//  collectionCell.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/4/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
//    variables
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var temperatureUnit: UILabel!
    
    @IBOutlet weak var weatherConditionImg: UIImageView!
    @IBOutlet weak var windDirection: UIImageView!
    
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windSpeedUnit: UILabel!
    
//    actions
    
    func configureCell(cityName: String, temp: String, tempUnit: String, weatherCondImg: UIImage, windDirectionImg: UIImage, windSpeed: String, windSpeedUnit: String){
        
        self.cityName.text = cityName
        temperature.text = temp
        temperatureUnit.text = tempUnit
        weatherConditionImg.image = weatherCondImg
        windDirection.image = windDirectionImg
        self.windSpeed.text = windSpeed
        self.windSpeedUnit.text = windSpeedUnit
    }
    
    
}
