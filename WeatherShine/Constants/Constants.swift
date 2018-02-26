//
//  Constants.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/5/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation
import CoreLocation

struct SegueConstants {
    static let toMainViewController = "MainVC"
    static let toLocationViewController = "LocationsVC"
    static let toUserSettingViewController = "UserSettingVC"
    static let toSearchViewController = "SearchVC"
    static let toPopUpViewController = "DeletePopUpVC"
}

struct APIConstants {
    static let APIKey = "f0c772209c098a69501d7b62742c209b"
    static let baseUrl = "https://api.darksky.net/forecast/\(APIKey)/"
    static let urlString = "\(baseUrl)\(latitude),\(longitude)"
    static let urlURL = URL(string: baseUrl)
    
    static let latitude : Double = 37.8267
    static let longitude : Double = -122.4233
}

struct cellsIdentifiers {
    static let tableCellID = "TableViewCell"
    static let collectionCellID = "collectionCell"
}

struct UserDefaultsKeys {
    static let tempUnitKey = "tempUnit"
    static let windSpeedUnitKey = "windSpeedUnit"
}
// https://api.darksky.net/forecast/APIKey/latitude,longitude
// https://api.darksky.net/forecast/0123456789abcdef9876543210fedcba/42.3601,-71.0589



