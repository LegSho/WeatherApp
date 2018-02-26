//
//  MainViewControllerExtensions.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/26/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

extension MainViewController: CLLocationManagerDelegate {
    
    func configureLocation(_ completion: @escaping (Bool) -> ()) {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
            completion(true)
        } else {
            completion(false)
        }
    }  
}



