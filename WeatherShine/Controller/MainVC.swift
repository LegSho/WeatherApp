//
//  MainVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/3/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
    //    variables
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var weatherConditionPicture: UIImageView!
    @IBOutlet weak var windSpeedPicture: UIImageView!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var tempUnitLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    
//    var cities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        scrollOrientation()
        viewDidLayoutSubviews()
        
//        let api = API(url: urlURL!)
//        api.getAPI { (result) in
//            print(result)
//        }

        let forecast = Forecast()
        forecast.getWeather(forLatitute: latitude, andLongitude: longitude) { (result) in
//            print(result.temperature, result.weatherIcon, result.windDirection, result.windSpeed, result)
        }
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLayoutSubviews()
        scrollOrientation()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    @IBAction func addNewLocationPressed(_ sender: Any) {
        guard let LVC = storyboard?.instantiateViewController(withIdentifier: to_LocationVC) as? LocationsVC else { return }
        transitionFromLeft(LVC)
        
        
    }
    
    @IBAction func userSettingsBtnPressed(_ sender: Any) {
        guard let USVC = storyboard?.instantiateViewController(withIdentifier: to_UserSettingVC) as? UserSettingVC else { return }
        transitionFromRight(USVC)
    }
    

    
    //    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    //
    //        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    //        if ((toInterfaceOrientation == UIInterfaceOrientation.landscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientation.landscapeRight)){
    //            layout.scrollDirection = UICollectionViewScrollDirection.vertical
    //        }
    //        else{
    //            layout.scrollDirection = UICollectionViewScrollDirection.horizontal
    //        }
    //    }
    
//    func swipe() {
//        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(animatedViewLeft))
//        swipe.direction = .left
//        cityNameLbl.addGestureRecognizer(swipe)
//    }
//
//    @objc func animatedViewLeft(){
//        guard let VC = storyboard?.instantiateViewController(withIdentifier: to_LocationVC) as? LocationsVC else { return}
//        present(VC, animated: false, completion: nil)
//
//    }
}


extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        return cell
    }
    
    func scrollOrientation(){
        if UIDevice.current.orientation.isPortrait {
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            layout?.scrollDirection = .vertical
            collectionView.reloadData()
        } else {
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            layout?.scrollDirection = .horizontal
            collectionView.reloadData()
        }
    }
    
    
    //    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    //        if UIDevice.current.orientation.isPortrait {
    //            collectionView
    //        } else {
    //
    //        }
    //    }
    
}



let appDelegate = UIApplication.shared.delegate as? AppDelegate





