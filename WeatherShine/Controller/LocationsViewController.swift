//
//  LocationsVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/4/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit
import CoreData

class LocationsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let dataFunction = DataFunctions()

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
        guard let MVC = storyboard?.instantiateViewController(withIdentifier: SegueConstants.toMainViewController) as? MainViewController else { return }
        transitionFromRight(MVC)
    }
    
    @IBAction func btnToSearchVCPressed(_ sender: Any) {
        guard let SVC = storyboard?.instantiateViewController(withIdentifier: SegueConstants.toSearchViewController) as? SearchViewController else { return }
        transitionFromLeft(SVC)
    }

    func dataForTable(){
        let favouriteCities = dataFunction.fetchData()
        guard let currentCity = favouriteCities.last else { return }
        self.currentCityForTable = currentCity
        self.listOfFavouriteCities = favouriteCities.filter{$0 != currentCity}
        self.reversedListOfFavouriteCities = listOfFavouriteCities.reversed()
    }
}


extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        title.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        title.text = "Favourite locations"
        if section == 0 {
            title.text = "Current location"
            return title
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellsIdentifiers.tableCellID, for: indexPath) as? TableViewCell else { return UITableViewCell() }
            guard let city = currentCityForTable else { return UITableViewCell()}
            cell.configureCell(name: city.name!)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellsIdentifiers.tableCellID, for: indexPath) as? TableViewCell else { return UITableViewCell() }
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
            let dataFunction = DataFunctions()
            dataFunction.deleteData(atIndexPath: indexPath, fromReversedListOfFavouriteCities: self.reversedListOfFavouriteCities)
            self.dataForTable()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        return [action]
    }
}
