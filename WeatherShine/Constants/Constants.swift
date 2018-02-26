//
//  Constants.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/5/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation
import CoreLocation

// VC Identifiers

let to_MainVC = "MainVC"
let to_LocationVC = "LocationsVC"
let to_UserSettingVC = "UserSettingVC"
let to_SearchVC = "SearchVC"
let to_PopUpView = "DeletePopUpVC"
// Dark Sky Net

let APIKey = "f0c772209c098a69501d7b62742c209b"
let latitude: Double = 37.8267
let longitude: Double = -122.4233
let baseUrl = "https://api.darksky.net/forecast/\(APIKey)/"
let urlString = "\(baseUrl)\(latitude),\(longitude)"
let urlURL = URL(string: baseUrl)

// https://api.darksky.net/forecast/APIKey/latitude,longitude
// https://api.darksky.net/forecast/0123456789abcdef9876543210fedcba/42.3601,-71.0589



