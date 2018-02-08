//
//  SearchVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/4/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class SearchVC: UIViewController {

    @IBOutlet weak var citySearchBar: UISearchBar!
    var temp: Double?
    var weatherCondition: String?
    var windSpeed: Double?
    var windDirection: Int32?

    override func viewDidLoad() {
        super.viewDidLoad()
        citySearchBar.delegate = self
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        guard let LVC = storyboard?.instantiateViewController(withIdentifier: to_LocationVC) as? LocationsVC else { return }
        transitionFromRight(LVC)
    }

    func returnToMainVC(){
        guard let VC = storyboard?.instantiateViewController(withIdentifier: to_MainVC) as? MainVC else { return}
        transitionFromRight(VC)
    }


}






extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            getWatherForSearchedLocation(location: searchBar.text!)
            guard let VC = self.storyboard?.instantiateViewController(withIdentifier: to_MainVC) as? MainVC else { return }
            VC.cityName = searchBar.text
            self.transitionFromRight(VC)
        }
    }
    
    func getWatherForSearchedLocation(location: String){
        CLGeocoder().geocodeAddressString(location) { (placemarks, err) in
            if err == nil {
                if let location = placemarks?.first?.location {
                    let forecast = Forecast.init()
                    forecast.getWeather(forLatitute: location.coordinate.latitude, andLongitude: location.coordinate.longitude, completion: { (result) in
                        guard let VC = self.storyboard?.instantiateViewController(withIdentifier: to_MainVC) as? MainVC else { return }
                        
                        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
                        let city = City(context: managedContext)
                        
                        print("result " + result.weatherIcon )
                        
                        city.temperature = result.temperature
                        city.weatherCondition = String(result.weatherIcon)
                        city.windSpeed = result.windSpeed
                        city.windDirection = Int32(result.windDirection)
                        
//                        print("city " + city.weatherCondition)
                        
                        do {
                            try managedContext.save()
                            print("Ima li kraja!!!!!!!!!")
                        } catch {
                            debugPrint("Error u pokusaju Catch-a za Data Core")
                        }
                        print("OVO JE OD CORE DATA:",city.temperature, city.weatherCondition, result.weatherIcon, city.windSpeed, city.windDirection)

//                        VC.temperature = city.temperature
//                        VC.weatherCondition = city.weatherCondition
//                        VC.windSpeed = result.windSpeed!
//                        VC.windDirection = result.windDirection!

//                        VC.initDataForMVC(temperaturE: result.temperature!, weatherConditioN: result.weatherIcon!, windSpeeD: result.windSpeed!, windDirectioN: result.windDirection!)
                       
                        print(city.temperature, city.weatherCondition, city.windSpeed, city.windDirection)
                    })
                }
            } else {
                print("Error: \(String(describing: err))")
            }
        }
    }
}
