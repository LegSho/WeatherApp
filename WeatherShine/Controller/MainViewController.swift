//
//  MainVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/3/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class MainViewController: UIViewController {
    
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
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var introductionImg: UIImageView!
    var tempUnit: String!
    var windUnit: String!
    var locationManager = CLLocationManager()
    var authorizationStatus = CLLocationManager.authorizationStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLayoutSubviews()
        locationManager.delegate = self
        configureLocation { (success) in
            if success {
                self.authorisation()
            }
        }
        collectionViewSetup()
        orientateDevice()
        scrollOrientation()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLayoutSubviews()
        collectionView.reloadData()
        scrollOrientation()
        orientateDevice()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    fileprivate func collectionViewSetup(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    fileprivate func authorisation(){
        if authorizationStatus != .denied {
            DispatchQueue.main.async {
                let dataFunction = DataFunctions()
                dataFunction.getCurrentLocation()
            }
        }
        DispatchQueue.main.async {
            let dataFunction = DataFunctions()
            dataFunction.deleteData()
        }
    }
    
    fileprivate func temperaturePresentation(temperatureInFahrenheit temp: Double) {
        if let userChoise = UserDefaults.standard.value(forKey: "tempUnit") as? Int {
            if cityNameLbl.text == "" {
                tempUnitLbl.isHidden = true
            }
            tempUnitLbl.isHidden = false
            let temperature = temp
            if userChoise == 0 {
                tempUnit = "°C"
                tempUnitLbl.text = tempUnit
                let result = String(format: "%.0f", (temperature-32) * 5/9)
                self.temperatureLbl.text = result
            } else {
                tempUnit = "°F"
                tempUnitLbl.text = tempUnit
                let result = String(format: "%.0f", temperature)
                self.temperatureLbl.text = result
            }
        }
    }
    
    fileprivate func windSpeedVelocityPresentation(speed: Double){
        if let userChoise = UserDefaults.standard.value(forKey: "windSpeedUnit") as? Int {
            if windSpeedLbl.text == "" {
                windSpeedUnit.isHidden = true
            }
            windSpeedUnit.isHidden = false
            let windSpeed = speed
            if userChoise == 0 {
                windUnit = "m/s"
                windSpeedUnit.text = windUnit
                let result = String(format: "%.0f", windSpeed)
                self.windSpeedLbl.text = result
            } else {
                windUnit = "km/h"
                windSpeedUnit.text = windUnit
                let result = String(format: "%.0f", (windSpeed * 3.6))
                self.windSpeedLbl.text = result
            }
        }
    }
    
    @IBAction func addNewLocationPressed(_ sender: Any) {
        guard let LVC = storyboard?.instantiateViewController(withIdentifier: SegueConstants.toLocationViewController) as? LocationsViewController else { return }
        transitionFromLeft(LVC)
    }
    
    @IBAction func userSettingsBtnPressed(_ sender: Any) {
        guard let USVC = storyboard?.instantiateViewController(withIdentifier: SegueConstants.toUserSettingViewController) as? UserSettingsViewController else { return }
        transitionFromRight(USVC)
    }

    fileprivate func setupView(){
        let function = Functions()
        function.currentDate { (date) in
            self.dateLbl.text = date
        }
        let dataFunction = DataFunctions()
        let favouriteCities = dataFunction.fetchData()
        function.hideOrUnhideFirstImg(favouriteCities: favouriteCities, image: introductionImg)
        self.cityNameLbl.text = favouriteCities.last?.name
        function.hideOrUnhideFirstImg(favouriteCities: favouriteCities, image: introductionImg)
        
        guard let temperature = favouriteCities.last?.temperature else { return }
        temperaturePresentation(temperatureInFahrenheit: temperature)
        
        guard let wind = favouriteCities.last?.windSpeed else { return }
        windSpeedVelocityPresentation(speed: wind)
        
        guard let direction = favouriteCities.last?.windDirection else { return }
        function.windDirectionPresentation(angle: direction, windSpeedPicture: windSpeedPicture)
        
        function.getPictureForAppropriateWeather(favouriteCities: favouriteCities, weatherConditionPic: weatherConditionPicture, backgroundImg: backgroundImg, cityNameLbl: cityNameLbl, dateLbl: dateLbl, temperatureLbl: temperatureLbl, tempUnitLbl: tempUnitLbl, windSpeedLbl: windSpeedLbl, windSpeedUnit: windSpeedUnit)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dataFunction = DataFunctions()
        let listOfCities = dataFunction.fetchData()
        var reversedCities: [City] = []
        let currentCity = listOfCities.last?.name
        let favouriteCitiesReversed : [City] = listOfCities.reversed()
        for city in favouriteCitiesReversed {
            if city.name != currentCity {
                reversedCities.append(city)
            }
        }
        print(favouriteCitiesReversed.count)
        return reversedCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsIdentifiers.collectionCellID, for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        let dataFunction = DataFunctions()
        let listOfCities = dataFunction.fetchData()
        
        let currentCity = listOfCities.last?.name
        let favouriteCitiesReversed : [City] = listOfCities.reversed()
        var reversedCities: [City] = []
        for city in favouriteCitiesReversed {
            if city.name != currentCity {
                reversedCities.append(city)
            }
        }
        let city = reversedCities[indexPath.row]
        cell.configureCell(city: city, tempUnit: tempUnit, windSpeedUnit: windUnit)
        return cell
    }
    
    fileprivate func scrollOrientation(){
        if UIDevice.current.orientation.isPortrait {
            UserDefaults.standard.set(true, forKey: "orientation")
        } else {
            UserDefaults.standard.set(false, forKey: "orientation")
        }
    }
    
    fileprivate func orientateDevice(){
        let orientation = UserDefaults.standard.value(forKey: "orientation") as! Bool
        if orientation {
            let scroll = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            scroll?.scrollDirection = .vertical
            collectionView.reloadData()
        } else {
            let scroll = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            scroll?.scrollDirection = .horizontal
            collectionView.reloadData()
        }
    }
}
