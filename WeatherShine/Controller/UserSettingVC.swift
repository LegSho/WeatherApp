//
//  UserSettingVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/4/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

class UserSettingVC: UIViewController {
    
    
    @IBOutlet weak var themeSegmentedController: UISegmentedControl!
    @IBOutlet weak var background: UIView!
    
    var celsiusFahrenheit = CelsiusFahrenheit.celsius
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeColor()
    }
    
    
    @IBAction func themeChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.isMomentary, forKey: "select")
        if(sender.selectedSegmentIndex == 0)
        {
            let segmentedControl = UserDefaults.standard
            segmentedControl.set(0, forKey: "KeyName")
            background.backgroundColor = UIColor.cyan
        }
        else if(sender.selectedSegmentIndex == 1)
        {
            let segmentedControl = UserDefaults.standard
            segmentedControl.set(1, forKey: "KeyName")
            background.backgroundColor = UIColor.blue
        }
    }
    
    func themeColor(){
        let theme = UserDefaults.standard.value(forKey: "KeyName")
        themeSegmentedController.selectedSegmentIndex = theme as! Int
        if themeSegmentedController.selectedSegmentIndex == 0 {
            background.backgroundColor = UIColor.cyan
//            guard let VC = storyboard?.instantiateViewController(withIdentifier: to_MainVC) as? MainVC else { return }
//            VC.userChangedBG(bgColor: background.backgroundColor!)
        } else {
            background.backgroundColor = UIColor.blue
//            guard let VC = storyboard?.instantiateViewController(withIdentifier: to_MainVC) as? MainVC else { return }
//            VC.userChangedBG(bgColor: background.backgroundColor!)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        guard let LVC = storyboard?.instantiateViewController(withIdentifier: to_LocationVC) as? LocationsVC else { return }
        transitionDismissLeft(LVC)
    }
    
}
