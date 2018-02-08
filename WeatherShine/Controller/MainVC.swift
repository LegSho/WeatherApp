//
//  MainVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/3/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class MainVC: UIViewController {
    
    //    variables
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var weatherConditionPicture: UIImageView!
    @IBOutlet weak var windSpeedPicture: UIImageView!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var windSpeedUnit: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var tempUnitLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    
//        var city = City()
    
    var favouriteCities: [City] = []
    
    var cityName: String?
    var weatherCondition: String?
    var temperature: Double?
    var windSpeed: Double?
    var windDirection: Int?
    var bg: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        viewDidLayoutSubviews()
        scrollOrientation()
        
        let forecast = Forecast()
        forecast.getWeather(forLatitute: latitude, andLongitude: longitude) { (result) in
        }

        cityNameLbl.text = cityName
        weatherConditionPicture.image = UIImage(named: "\(weatherCondition)")
        print("\(weatherCondition)")
 
        
         
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        scrollOrientation()
        viewDidLayoutSubviews()
        cityNameLbl.text = cityName
        print("Var MVC-a za izjednacavanje sa City():", cityName, weatherCondition, temperature, windSpeed, windDirection)

        self.mainView.backgroundColor = bg
        self.fetchData { (completed) in
            if completed {
                if favouriteCities.count >= 1 {
                 collectionView.isHidden = false
                    collectionView.reloadData()
                }
            } else {
                collectionView.isHidden = true
                collectionView.reloadData()
            }
        }
        
        self.tempUnitLbl.text = String(format:"%.0f",favouriteCities[3].temperature)
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
    
//    OVO NE USPEVA DA URADI! ! ! ! ! i zato dobijam NIL za temp,wind,direct,icon
    
    func initDataForMVC(temperaturE: Double!, weatherConditioN: String! ,windSpeeD: Double!, windDirectioN: Int!){
        
        guard let condition = weatherConditioN else { return }
        self.weatherCondition = condition
        
        self.temperature = temperaturE
        self.windSpeed = windSpeeD
        self.windDirection = windDirectioN
        print("Unutrasnji parametri za InitDataForMVC su :", temperature, weatherCondition, windSpeed, windDirection)
        
    }
    
    
    func fetchData(_ completion: (Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<City>(entityName: "City")
        
        do {
            favouriteCities = try managedContext.fetch(fetchRequest)
            print("Successfully fetched data.")
            completion(true)
        } catch {
            debugPrint("Error: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    
    
    
    
    
    
    func windDirectionPresentation(angle: Int){
        if angle == 0 {
            //            post WindDirection Image for 0 degrees
        } else if angle > 0 && angle < 90 {
            //            post WindDirection Image for I quadrant
        } else if angle == 90 {
            //            post WindDirection Image for 90 degrees
        } else if angle > 90 && angle < 180 {
            //            post WindDirection Image for II quadrant
        } else if angle == 180 {
            //            post WindDirection Image for 180 degrees
        } else if angle > 180 && angle < 270 {
            //            post WindDirection Image for III quadrant
        } else if angle == 270 {
            //            post WindDirection Image for 270 degrees
        } else if angle > 270 {
            //            post WindDirection Image for IV quadrant
        }
        
    }
}









extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        let favouriteCitiesReversed : [City] = favouriteCities.reversed()
        let city = favouriteCitiesReversed[indexPath.row]
        cell.configureCell(city: city, tempUnit: "°C", windSpeedUnit: "m/s")
        return cell
    }
    
    func scrollOrientation(){
//        if UIDevice.current.orientation.isPortrait {
//            UserDefaults.standard.set(true, forKey: "orientation")
//        } else if UIDevice.current.orientation.isLandscape {
//            UserDefaults.standard.set(false, forKey: "orientation")
//        }
        
        collectionView.reloadData()
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
    
//    func orientateDevice(){
//        guard let orientation = UserDefaults.standard.value(forKey: "orientation") as? Bool else { return }
//        if orientation {
//            let scroll = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
//            scroll?.scrollDirection = .vertical
//            collectionView.reloadData()
//        } else {
//            let scroll = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
//            scroll?.scrollDirection = .horizontal
//            collectionView.reloadData()
//        }
//    }
    
    
}







//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        if UIDevice.current.orientation.isPortrait {
//            collectionView
//        } else {
//
//        }
//    }









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
