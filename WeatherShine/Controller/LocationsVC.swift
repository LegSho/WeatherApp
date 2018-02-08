//
//  LocationsVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/4/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

class LocationsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.isHidden = false  if there is any favourite city in there
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        guard let MVC = storyboard?.instantiateViewController(withIdentifier: to_MainVC) as? MainVC else { return }
        transitionFromRight(MVC)
    }
    
    @IBAction func btnToSearchVCPressed(_ sender: Any) {
        guard let SVC = storyboard?.instantiateViewController(withIdentifier: to_SearchVC) as? SearchVC else { return }
        transitionFromLeft(SVC)
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = UILabel()
        title.textAlignment = .center
        title.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        title.text = "Favourite locations"
        if section == 0 {
            title.text = "Current location"
            return title
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        return cell
    }
    
    
}





