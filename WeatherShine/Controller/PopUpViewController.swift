//
//  PopUpVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/15/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBAction func cancelBtnPressed(_ sender: CustomButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteBtnPressed(_ sender: CustomButton) {
        let dataFunction = DataFunctions()
        dataFunction.deleteData()
        guard let vc = storyboard?.instantiateViewController(withIdentifier: SegueConstants.toMainViewController) as? MainViewController else { return }
        present(vc, animated: true, completion: nil)
    }
}
