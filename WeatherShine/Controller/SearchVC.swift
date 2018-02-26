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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citySearchBar.delegate = self
        activityIndicator.hidesWhenStopped = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        closeKeyboard()
        citySearchBar.bindToKeyboard()
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        guard let LVC = storyboard?.instantiateViewController(withIdentifier: to_LocationVC) as? LocationsVC else { return }
        transitionFromRight(LVC)
    }
    
    func returnToMainVC(){
        guard let VC = storyboard?.instantiateViewController(withIdentifier: to_MainVC) as? MainVC else { return}
        transitionFromRight(VC)
    }
    
    func closeKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        self.view.endEditing(true)
    }
}





extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            activityIndicator.startAnimating()
            getLocation(locationAsText: searchBar.text!)
        }
    }
    
    func getLocation(locationAsText: String){
        CLGeocoder().geocodeAddressString(locationAsText) { (placemarks, err) in
            if err == nil {
                if let location = placemarks?.first?.location {
                    let api = API()
                    api.getWeatherAndAPI(forLatitute: location.coordinate.latitude, andLongitude: location.coordinate.longitude, { (dictionary) in
                        _ = self.makeCoreDataEntity(cityName: locationAsText, jsonDictionary: dictionary!)
                        print("Successfully made CoreData Entity.")
                    })
                }
            }
        }
    }
    
    func makeCoreDataEntity(cityName: String?, jsonDictionary: [String: Any]) -> NSManagedObject? {
        let managedContext = CoreDataStack.instance.persistentContainer.viewContext
        if let city = NSEntityDescription.insertNewObject(forEntityName: "City", into: managedContext) as? City {
            city.name = cityName
            city.temperature = (jsonDictionary["temperature"] as? Double)!
            city.weatherCondition = jsonDictionary["icon"] as? String
            city.windSpeed = (jsonDictionary["windSpeed"] as? Double)!
            city.windDirection = Int32(jsonDictionary["windBearing"] as! Int)
            print(city.name ?? "City Name", city.temperature, city.weatherCondition ?? "Weather Condition", city.windSpeed, city.windDirection)
            do{
                try managedContext.save()
                DispatchQueue.main.async {
                    if let MVC = self.storyboard?.instantiateViewController(withIdentifier: to_MainVC) as? MainVC {
                        self.present(MVC, animated: true, completion: nil)
                        self.activityIndicator.stopAnimating()
                    }
                }
            }catch {
                debugPrint("Error:", error.localizedDescription)
            }
            return city
        } else {
            return nil
        }
    }
}







