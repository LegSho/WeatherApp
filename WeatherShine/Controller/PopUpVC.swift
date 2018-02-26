//
//  PopUpVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/15/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

class PopUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancelBtnPressed(_ sender: DeleteBtn) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteBtnPressed(_ sender: DeleteBtn) {
        deleteData()
        guard let vc = storyboard?.instantiateViewController(withIdentifier: to_MainVC) as? MainVC else { return }
        present(vc, animated: true, completion: nil)
    }
}
