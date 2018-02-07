//
//  SearchVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/4/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit
import CoreLocation

class SearchVC: UIViewController {

    @IBOutlet weak var citySearchBar: UISearchBar!
    
//    var dataArray = [DarkSky]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citySearchBar.delegate = self
        
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        guard let LVC = storyboard?.instantiateViewController(withIdentifier: to_LocationVC) as? LocationsVC else { return }
        transitionDismissRight(LVC)
    }
}


extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            getWatherForSearchedLocation(location: searchBar.text!)
        }
    }
    
    
    
    func getWatherForSearchedLocation(location: String){
        CLGeocoder().geocodeAddressString(location) { (placemarks, err) in
            if err == nil {
                if let location = placemarks?.first?.location {
                    let forecast = Forecast.init()
                    forecast.getWeather(forLatitute: location.coordinate.latitude, andLongitude: location.coordinate.longitude, completion: { (result) in
                        print("\(String(describing: result.temperature)), \(String(describing: result.weatherIcon)), \(String(describing: result.windSpeed)),  \(String(describing: result.windDirection))")
                    })
                }
            } else {
                print("Error: \(err)")
            }
        }
    }
    
    
    

    
//    func getWeatherForSearchedLocation(location: String){
//        CLGeocoder().geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
//            if error == nil {
//                if let location = placemarks?.first?.location {
//                    DarkSky.getDarkSkyAPI(forLocation: location.coordinate, completion: { (result) in
//
//
//                    })
//                }
//            }
//        }
//    }
    
    
    
}
