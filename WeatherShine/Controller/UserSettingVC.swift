//
//  UserSettingVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/4/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

class UserSettingVC: UIViewController {
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var temperatureSegmentedController: UISegmentedControl!
    @IBOutlet weak var windSpeedSegmentedController: UISegmentedControl!
    @IBOutlet weak var background: UIView!

    var tempUnit = "tempUnit"
    var windSpeedUnit = "windSpeedUnit"
    var themeType = "theme"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUnits()
    }
    
    @IBAction func temperatureUnitChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.isMomentary, forKey: tempUnit)
        if sender.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(0, forKey: tempUnit)
        } else {
            UserDefaults.standard.set(1, forKey: tempUnit)
        }
    }
    
    @IBAction func windSpeedUnitChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.isMomentary, forKey: windSpeedUnit)
        if sender.selectedSegmentIndex == 0 {
           UserDefaults.standard.set(0, forKey: windSpeedUnit)
        } else {
            UserDefaults.standard.set(1, forKey: windSpeedUnit)
        }
    }
    
    func setupUnits(){
        let tempUnit = UserDefaults.standard.value(forKey: self.tempUnit)
        temperatureSegmentedController.selectedSegmentIndex = (tempUnit as! Int)
        let windSpeedUnit = UserDefaults.standard.value(forKey: self.windSpeedUnit)
        windSpeedSegmentedController.selectedSegmentIndex = windSpeedUnit as! Int
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        guard let LVC = storyboard?.instantiateViewController(withIdentifier: to_LocationVC) as? LocationsVC else { return }
        transitionDismissLeft(LVC)
    }
    
}
