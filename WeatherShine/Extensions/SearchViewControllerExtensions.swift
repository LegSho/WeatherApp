//
//  SearchViewControllerExtensions.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/26/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            activityIndicator.startAnimating()
            let dataFunction = DataFunctions()
            dataFunction.getLocation(locationAsText: searchBar.text!, completion: { (locationFound) in
                if locationFound {
                    DispatchQueue.main.async {
                        if let MVC = self.storyboard?.instantiateViewController(withIdentifier: SegueConstants.toMainViewController) as? MainViewController {
                            self.present(MVC, animated: true, completion: nil)
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            })
        }
    }
}
