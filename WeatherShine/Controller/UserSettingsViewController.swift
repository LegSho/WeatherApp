//
//  UserSettingVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/4/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

class UserSettingsViewController: UIViewController {
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var temperatureSegmentedController: UISegmentedControl!
    @IBOutlet weak var windSpeedSegmentedController: UISegmentedControl!
    @IBOutlet weak var background: UIView!

//    var tempUnit = "tempUnit"
//    var windSpeedUnit = "windSpeedUnit"
//    var themeType = "theme"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUnits()
    }
    
    @IBAction func temperatureUnitChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.isMomentary, forKey: UserDefaultsKeys.tempUnitKey)
        if sender.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(0, forKey: UserDefaultsKeys.tempUnitKey)
        } else {
            UserDefaults.standard.set(1, forKey: UserDefaultsKeys.tempUnitKey)
        }
    }
    
    @IBAction func windSpeedUnitChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.isMomentary, forKey: UserDefaultsKeys.windSpeedUnitKey)
        if sender.selectedSegmentIndex == 0 {
           UserDefaults.standard.set(0, forKey: UserDefaultsKeys.windSpeedUnitKey)
        } else {
            UserDefaults.standard.set(1, forKey: UserDefaultsKeys.windSpeedUnitKey)
        }
    }
    
    func setupUnits(){
        let tempUnit = UserDefaults.standard.value(forKey: UserDefaultsKeys.tempUnitKey)
        temperatureSegmentedController.selectedSegmentIndex = (tempUnit as! Int)
        let windSpeedUnit = UserDefaults.standard.value(forKey: UserDefaultsKeys.windSpeedUnitKey)
        windSpeedSegmentedController.selectedSegmentIndex = windSpeedUnit as! Int
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        guard let LVC = storyboard?.instantiateViewController(withIdentifier: SegueConstants.toLocationViewController) as? LocationsViewController else { return }
        transitionDismissLeft(LVC)
    }
    
}
