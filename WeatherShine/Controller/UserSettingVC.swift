//
//  UserSettingVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/4/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

class UserSettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func backBtnPressed(_ sender: Any) {
        guard let LVC = storyboard?.instantiateViewController(withIdentifier: to_LocationVC) as? LocationsVC else { return }
        transitionDismissLeft(LVC)
    }
    
}
