//
//  SearchVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/4/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class SearchViewController: UIViewController {
    
    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citySearchBar.delegate = self
        activityIndicator.hidesWhenStopped = true
    }
 
    @IBAction func backBtnPressed(_ sender: Any) {
        guard let LVC = storyboard?.instantiateViewController(withIdentifier: SegueConstants.toLocationViewController) as? LocationsViewController else { return }
        transitionFromRight(LVC)
    }
}

extension SearchViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        closeKeyboard()
        citySearchBar.bindToKeyboard()
    }
    
    fileprivate func closeKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        self.view.endEditing(true)
    }
}






