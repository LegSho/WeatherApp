//
//  LocationsVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/4/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit
import CoreData

class LocationsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentCityForTable: City?
    var listOfFavouriteCities: [City?] = []
    var reversedListOfFavouriteCities: [City?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dataForTable()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        guard let MVC = storyboard?.instantiateViewController(withIdentifier: to_MainVC) as? MainVC else { return }
        transitionFromRight(MVC)
    }
    
    @IBAction func btnToSearchVCPressed(_ sender: Any) {
        guard let SVC = storyboard?.instantiateViewController(withIdentifier: to_SearchVC) as? SearchVC else { return }
        transitionFromLeft(SVC)
    }

    func fetchData(_ completion: (Bool) -> ()) {
        let managedContext = CoreDataStack.instance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<City>(entityName: "City")
        
        do {
            listOfFavouriteCities = try managedContext.fetch(fetchRequest)
            print("Successfully fetched data.", listOfFavouriteCities.count)
            completion(true)
        } catch {
            debugPrint("Error: \(error.localizedDescription)")
            completion(false)
        }
    }

    func dataForTable(){
        fetchData { (success) in
            if success {
                guard let currentCity = listOfFavouriteCities.last else { return }
                self.currentCityForTable = currentCity
                self.listOfFavouriteCities = listOfFavouriteCities.filter{ $0 != currentCity}
                self.reversedListOfFavouriteCities = listOfFavouriteCities.reversed()
            }
        }
    }
    
    func deleteData(atIndexPath indexPath: IndexPath) {
        let managedContext = CoreDataStack.instance.persistentContainer.viewContext
        guard let favouriteCities = reversedListOfFavouriteCities as? [City] else { return }
        managedContext.delete(favouriteCities[indexPath.row])
        do {
            try managedContext.save()
        } catch let error {
            print("Could not remove, error:","\(error)")
        }
    }
    
}




extension LocationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return reversedListOfFavouriteCities.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = UILabel()
        title.textAlignment = .left
        title.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        title.text = "Favourite locations"
        if section == 0 {
            title.text = "Current location"
            return title
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
            guard let city = currentCityForTable else { return UITableViewCell()}
            cell.configureCell(name: city.name!)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
            guard let city = reversedListOfFavouriteCities[indexPath.row]?.name else { return UITableViewCell() }
            cell.configureCell(name: city)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.deleteData(atIndexPath: indexPath)
            self.dataForTable()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        return [action]
    }
}





