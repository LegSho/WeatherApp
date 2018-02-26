//
//  DataFunctions.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/26/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

class DataFunctions {
    
    func fetchCity(location: CLLocation, completion: @escaping (String) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print(error)
            } else if let city = placemarks?.first?.locality {
                completion(city)
            }
        }
    }
    
    func getLocation(locationAsText: String, completion: @escaping (Bool) -> ()){
        CLGeocoder().geocodeAddressString(locationAsText) { (placemarks, err) in
            if err == nil {
                if let location = placemarks?.first?.location {
                    let api = API()
                    api.getWeatherAndAPI(forLatitute: location.coordinate.latitude, andLongitude: location.coordinate.longitude, { (dictionary) in
                        _ = self.makeCoreDataEntity(cityName: locationAsText, jsonDictionary: dictionary!)
                        print("Successfully made CoreData Entity.")
                        completion(true)
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
                
            } catch {
                print(error.localizedDescription)
            }
            return city
        }
        return nil
    }
    
    func fetchData() -> [City] {
        let managedContext = CoreDataStack.instance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<City>(entityName: "City")
        var favouriteCities: [City] = []
        do {
            let cities = try managedContext.fetch(fetchRequest)
            favouriteCities = cities
            print("Successfully fetched data.")
        } catch {
            debugPrint("Error: \(error.localizedDescription)")
        }
        return favouriteCities
    }
    
    func deleteData(){
        let managedContext = CoreDataStack.instance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<City>(entityName: "City")
        do{
            let data = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            _ = data.map{ $0.map{managedContext.delete($0)}}
            CoreDataStack.instance.saveContext()
            print("Successfully deleted data.")
        } catch let error {
            print("Unsuccessfully deleted data, caused by: \(error).")
        }
    }
    
    func deleteData(atIndexPath indexPath: IndexPath, fromReversedListOfFavouriteCities reversedListOfFavouriteCities: [City?]) {
        let managedContext = CoreDataStack.instance.persistentContainer.viewContext
        guard let favouriteCities = reversedListOfFavouriteCities as? [City?] else { return }
        managedContext.delete(favouriteCities[indexPath.row]!)
        do {
            try managedContext.save()
        } catch let error {
            print("Could not remove, error:","\(error)")
        }
    }
}
